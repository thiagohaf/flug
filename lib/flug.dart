library flug;

import 'dart:async';
import 'dart:isolate';

import 'package:flug/flug.container.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flug/report.dart';

class Flug {
  static Widget _rootWidget;
  static String _reportServer;
  static String _reportKey;

  static void init(@required Widget rootWidget, String reportServer, String reportKey) {
    Flug._reportServer = reportServer;
    Flug._reportKey = reportKey;
    Flug._rootWidget = rootWidget;

    _runAppWithFlug();
  }

  static void _runAppWithFlug() async {
    FlutterError.onError = (FlutterErrorDetails details) async {
      await _reportError(details.exception.toString(), details.stack.toString());
    };

    await Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
      var isolateError = pair as List<dynamic>;
      await _reportError(isolateError.first.toString(), isolateError.last.toString());
    }).sendPort);

    runZoned<Future<void>>(() async {
      await runApp(_rootWidget);
    }, onError: (error, stackTrace) async {
      await _reportError(error.toString(), stackTrace.toString());
    });
  }

 static void _reportError(String error, String stackTrace) async {
      var report = await new Report(_reportServer, _reportKey);               
      var sendStatus = await report.sendErrorReport(error, stackTrace);

      debugPrint('sendStatus $sendStatus');
  }

  static Widget materialAppBuilder(BuildContext context, Widget child) {
    return Navigator(onGenerateRoute: (settings) {
      return MaterialPageRoute(builder: (context) {
        return FlugContainer(
            bugReportServer: Flug._reportServer,
            bugReportKey: Flug._reportKey,
            child: child);
      });
    });
  }
}
