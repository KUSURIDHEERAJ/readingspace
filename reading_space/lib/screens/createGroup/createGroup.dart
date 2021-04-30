import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/screens/addBook/addBook.dart';
import 'package:reading_space/screens/root/root.dart';
import 'package:reading_space/services/database.dart';
import 'package:reading_space/states/currentUser.dart';
import 'package:reading_space/widgets/OurContainer.dart';

class OurCreateGroup extends StatefulWidget {
  @override
  _OurCreateGroupState createState() => _OurCreateGroupState();
}

class _OurCreateGroupState extends State<OurCreateGroup> {
  void goToAddBook(BuildContext context, String groupName) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurAddBook(
          onGroupCreation: true,
          groupName: groupName,
        ),
      ),
    );
  }

  TextEditingController groupNameController = TextEditingController();
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
            padding: const EdgeInsets.all(30.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Add Book",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        goToAddBook(context, groupNameController.text),
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
