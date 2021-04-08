import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/states/currentUser.dart';
import 'package:reading_space/widgets/OurContainer.dart';

class OurSignUpForm extends StatefulWidget {
  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  void signUpUser(String email, String password, BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      if (await currentUser.signUpUser(email, password)) {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: fullNameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline), hintText: "Full Name"),
          ),
          SizedBox(
            height: 10.0,
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
          TextFormField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open),
                hintText: "Confirm Password"),
            obscureText: true,
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            onPressed: () {
              if (passwordController.text == confirmPasswordController.text) {
                signUpUser(
                    emailController.text, passwordController.text, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Passwords do not match'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
