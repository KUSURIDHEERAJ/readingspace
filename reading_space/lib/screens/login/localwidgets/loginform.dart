import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:reading_space/screens/home/home.dart';
import 'package:reading_space/screens/root/root.dart';
import 'package:reading_space/screens/signup/signup.dart';
import 'package:reading_space/states/currentUser.dart';
import 'package:reading_space/widgets/OurContainer.dart';

enum LoginType {
  email,
  google,
}

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginUser({
    @required LoginType type,
    String email,
    String password,
    BuildContext context,
  }) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String returnString;
      switch (type) {
        case LoginType.email:
          returnString = await currentUser.loginUserwithEmail(email, password);
          break;
        case LoginType.google:
          returnString = await currentUser.loginUserwithGoogle();
          break;
      }

      if (returnString == "Success") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OurRoot(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Widget googleButton() {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.blue.shade400
              : Colors.grey;
          return BorderSide(color: color, width: 2);
        }),
      ),
      //icon: Image.asset("assets/google_logo.png")
      onPressed: () {
        loginUser(type: LoginType.google, context: context);
      },
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image.asset('assets/google_logo1.png', height: 20.0, width: 20.0),
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: new Text(
                "Sign In With Google",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Text(
              "Log In",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
            obscureText: true,
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Log In",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            onPressed: () {
              loginUser(
                  type: LoginType.email,
                  email: emailController.text,
                  password: passwordController.text,
                  context: context);
            },
          ),
          TextButton(
            child: Text("Don't have an account ? Sign Up here"),
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurSignUp(),
                ),
              );
            },
          ),
          googleButton()
        ],
      ),
    );
  }
}
