import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/states/currentUser.dart';
//import 'package:reading_space/screens/login/login.dart';
import 'package:reading_space/utils/OurTheme.dart';
import 'package:reading_space/screens/root/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //this widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: OurTheme().buildTheme(),
        home: OurRoot(),
      ),
    );
  }
}
