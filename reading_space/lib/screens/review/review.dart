import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/states/currentGroup.dart';
import 'package:reading_space/states/currentUser.dart';
import 'package:reading_space/widgets/OurContainer.dart';

class OurReview extends StatefulWidget {
  final CurrentGroup currentGroup;
  OurReview({this.currentGroup});
  @override
  _OurReviewState createState() => _OurReviewState();
}

class _OurReviewState extends State<OurReview> {
  TextEditingController reviewController = TextEditingController();
  int dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Rate book 1-10:"),
                      DropdownButton<int>(
                        value: dropDownValue,
                        icon: Icon(Icons.filter_list),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor),
                        underline: Container(
                          height: 2,
                          color: Colors.white38,
                        ),
                        dropdownColor: Colors.white,
                        onChanged: (int newValue) {
                          setState(() {
                            dropDownValue = newValue;
                          });
                        },
                        items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  TextFormField(
                    controller: reviewController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.group),
                      hintText: "Add a Review",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Add Review",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {
                      String uid =
                          Provider.of<CurrentUser>(context, listen: false)
                              .getCurrentUser
                              .uid;
                      widget.currentGroup.finishedBook(
                          uid, dropDownValue, reviewController.text);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
