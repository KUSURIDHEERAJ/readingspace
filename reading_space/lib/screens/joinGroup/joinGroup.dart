import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/screens/root/root.dart';
import 'package:reading_space/services/database.dart';
import 'package:reading_space/states/currentUser.dart';
import 'package:reading_space/widgets/OurContainer.dart';

class OurJoinGroup extends StatefulWidget {
  @override
  _OurJoinGroupState createState() => _OurJoinGroupState();
}

class _OurJoinGroupState extends State<OurJoinGroup> {
  void joinGroup(BuildContext context, String groupId) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString =
        await OurDatabase().joinGroup(groupId, currentUser.getCurrentUser.uid);
    if (returnString == "Success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OurRoot(),
          ),
          (route) => false);
    }
  }

  TextEditingController groupIdController = TextEditingController();
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
                    textAlignVertical: TextAlignVertical.center,
                    controller: groupIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Id",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Join Group",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ))),
                    onPressed: () => joinGroup(context, groupIdController.text),
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
