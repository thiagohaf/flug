// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:http/http.dart' as http;

class FlugRaiting extends StatefulWidget {
  final Function onPressed;
  TextEditingController _ratingController = TextEditingController();
  double _userRating = 3;
  FlugRaiting({Key key, this.onPressed}) : super(key: key);

  @override
  _FlugRaitingState createState() => _FlugRaitingState();
}

class _FlugRaitingState extends State<FlugRaiting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              "Deixe seu comentário para que possamos melhorar, é importante sabermos sua opinião.",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFDDDDDD),
              ),
            ),
            SizedBox(height: 20),
            RatingBar(
              initialRating: widget._userRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                this.setState(() {
                  widget._userRating = rating;
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: widget._ratingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.lightGreen,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "Deixe seu comentário",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              // onPressed: widget.onPressed(
              //     widget._userRating, widget._ratingController.text),
              onPressed: () {},
              color: Colors.lightGreen,
              child: const Text('Enviar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
