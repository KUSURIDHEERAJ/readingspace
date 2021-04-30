import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/models/book.dart';
import 'package:reading_space/screens/root/root.dart';
import 'package:reading_space/services/database.dart';
import 'package:reading_space/states/currentUser.dart';
import 'package:reading_space/widgets/OurContainer.dart';

class OurAddBook extends StatefulWidget {
  final bool onGroupCreation;
  final String groupName;
  OurAddBook({
    this.onGroupCreation,
    this.groupName,
  });
  @override
  _OurAddBookState createState() => _OurAddBookState();
}

class _OurAddBookState extends State<OurAddBook> {
  TextEditingController bookNameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime picked =
        await DatePicker.showDateTimePicker(context, showTitleActions: true);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void addBook(BuildContext context, String groupName, OurBook book) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString;
    if (widget.onGroupCreation) {
      returnString = await OurDatabase()
          .createGroup(groupName, currentUser.getCurrentUser.uid, book);
    } else {
      returnString =
          await OurDatabase().addBook(currentUser.getCurrentUser.groupId, book);
    }

    if (returnString == "Success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OurRoot(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: bookNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.book),
                      hintText: "Book Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: authorController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      hintText: "Author Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: lengthController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.article_outlined),
                      hintText: "Pages Count",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(DateFormat.yMMMMd("en_US").format(selectedDate)),
                  Text(DateFormat("H:mm").format(selectedDate)),
                  TextButton(
                    child: Text("Change Date & Time"),
                    onPressed: () => selectDate(context),
                  ),
                  //datePicker package we are going to use for selecting dates
                  ElevatedButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Create ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () {
                        OurBook book = OurBook();
                        book.name = bookNameController.text;
                        book.author = authorController.text;
                        book.length = int.parse(lengthController.text);
                        book.dateCompleted = Timestamp.fromDate(selectedDate);
                        addBook(context, widget.groupName, book);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
