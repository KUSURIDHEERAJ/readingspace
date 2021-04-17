import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/screens/addBook/addBook.dart';
import 'package:reading_space/screens/noGroup/noGroup.dart';
import 'package:reading_space/screens/review/review.dart';
import 'package:reading_space/screens/root/root.dart';
import 'package:reading_space/states/currentGroup.dart';
import 'package:reading_space/states/currentUser.dart';
import 'package:reading_space/utils/timeLeft.dart';
import 'package:reading_space/widgets/OurContainer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> timeUntil = List(2); //[0] time until the book is due
  //[1] time until the new book is revealed
  Timer _timer;
  void startTimer(CurrentGroup currentGroup) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeUntil = OurTimeLeft().timeLeft(currentGroup
            .getCurrentGroup.currentBookDue
            .toDate()); //function that we call
      });
    });
  }

  @override
  void initState() {
    // implement initState
    super.initState();
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    CurrentGroup currentGroup =
        Provider.of<CurrentGroup>(context, listen: false);
    currentGroup.updateStateFromDatabase(
        currentUser.getCurrentUser.groupId, currentUser.getCurrentUser.uid);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void goToAddBook(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurAddBook(
          onGroupCreation: false,
        ),
      ),
    );
  }

  void goToReview() {
    CurrentGroup currentGroup =
        Provider.of<CurrentGroup>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurReview(
          currentGroup: currentGroup,
        ),
      ),
    );
  }

  void signOut(BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await currentUser.signOut();
    if (returnString == "Success") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OurRoot(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Consumer<CurrentGroup>(
                builder: (BuildContext context, value, Widget child) {
                  return Column(
                    children: <Widget>[
                      Text(
                        value.getCurrentBook.name ?? "loading ...",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.indigo,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Due In :  ",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey[600],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (value.getCurrentGroup.currentBookDue != null)
                                    ? value.getCurrentGroup.currentBookDue
                                        .toDate()
                                        .toString()
                                    : "loading...",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          "Finished Book",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed:
                            value.getDoneWithCurrentBook ? null : goToReview,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Next Book\nRevealed In: ",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      timeUntil[1] ?? "loading...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
            child: OutlinedButton(
              child: Text(
                "Add New Book",
                style: TextStyle(color: Colors.black),
              ),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.white54,
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.blue, width: 2),
              ),
              onPressed: () => goToAddBook(context),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
            child: OutlinedButton(
              child: Text(
                "Reading Space History",
                style: TextStyle(color: Colors.black),
              ),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.white54,
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.blue, width: 2),
              ),
              onPressed: () => goToAddBook(context),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 123.0, vertical: 10.0),
            child: ElevatedButton(
              child: Text("Sign Out"),
              onPressed: () => signOut(context),
            ),
          )
        ],
      ),
    );
  }
}
