import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/screens/home/home.dart';
import 'package:reading_space/screens/login/login.dart';
import 'package:reading_space/screens/noGroup/noGroup.dart';
import 'package:reading_space/screens/splashScreen/splashScreen.dart';
import 'package:reading_space/states/currentGroup.dart';
import 'package:reading_space/states/currentUser.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  notInGroup,
  inGroup,
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus authStatus = AuthStatus.unknown;
  @override
  void didChangeDependencies() async {
    //  implement didChangeDependencies
    super.didChangeDependencies();
    //get the state,check current User ,Set AuthStatus based on state
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await currentUser.onStartUp();
    if (returnString == "Success") {
      if (currentUser.getCurrentUser.groupId != null) {
        setState(() {
          authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(() {
          authStatus = AuthStatus.notInGroup;
        });
      }
    } else {
      setState(() {
        authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget returnVal;
    switch (authStatus) {
      case AuthStatus.unknown:
        returnVal = OurSplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        returnVal = OurLogin();
        break;
      case AuthStatus.notInGroup:
        returnVal = OurNoGroup();
        break;
      case AuthStatus.inGroup:
        returnVal = ChangeNotifierProvider(
          create: (context) => CurrentGroup(),
          child: HomeScreen(),
        );
        break;
      default:
    }
    return returnVal;
  }
}
