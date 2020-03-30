import 'dart:convert';

import 'package:flug/widgets/flug.raiting.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flug/flug.device.dart';
import 'package:flug/models/device.model.dart';

@protected
class Report {
  final String bugReportServer;
  final String bugReportKey;
  Report(this.bugReportServer, this.bugReportKey);

  Future<int> sendReport(String email, String description, String image) async {
    debugPrint("[Sending Report] [${this.bugReportKey}] - $description");

    var url = '$bugReportServer/bug-report';
    var imageBase64 = 'data:image/png;base64,' + image;
    var _headers = Map<String, String>();

    _headers["Content-Type"] = "application/json";
    // _headers['Authorization'] = this.bugReportKey;

    final device = await _getDevice();
    var createdAt = DateTime.now().toIso8601String();
    var response = await http.post(
      url,
      headers: _headers,
      body: json.encode({
        'key': this.bugReportKey,
        'description': description,
        'imageURL': imageBase64,
        'device': device,
        'email': email,
        'appName': device.appName,
        'appVersion': device.appVersion,
        'buildNumber': device.buildNumber,
        'packageName': device.packageName,
        'createdAt': createdAt
      }),
    );

    return response.statusCode;
  }

  Future<int> sendErrorReport(String error, String stacktrace) async {
    debugPrint(
        "[Sending Error Report] [${this.bugReportKey}] - Error: $error; StackTrace: $stacktrace");

    var url = '$bugReportServer/error-report';
    var _headers = Map<String, String>();

    _headers["Content-Type"] = "application/json";
    // _headers['Authorization'] = this.bugReportKey;

    final device = await _getDevice();
    var createdAt = DateTime.now().toIso8601String();
    var response = await http.post(
      url,
      headers: _headers,
      body: json.encode({
        'key': this.bugReportKey,
        'device': device,
        'error': error,
        'stackTrace': stacktrace,
        'appName': device.appName,
        'appVersion': device.appVersion,
        'buildNumber': device.buildNumber,
        'packageName': device.packageName,
        'createdAt': createdAt
      }),
    );
    return response.statusCode;
  }

  Future<DeviceModel> _getDevice() async {
    DeviceModel device;

    await FlugDevice.getDevice().then((result) => device = result);

    return device;
  }

  Future<int> sendVote(double rating, String comment) async {
    print("Nota $rating => $comment");

    // var url = '';
    // var _headers = Map<String, String>();

    // _headers["Content-Type"] = "application/json";
    // String createdAt = DateTime.now().toIso8601String();
    // print("chegou ===> $rating  e $comment");
    // var response = await http.post(url,
    //     headers: _headers,
    //     body: json.encode({
    //       'rating': rating,
    //       'comment': comment,
    //       'createdAt': createdAt,
    //     }));
    return 1;
  }
}
