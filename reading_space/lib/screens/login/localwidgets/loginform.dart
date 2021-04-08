import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_space/screens/home/home.dart';
import 'package:reading_space/screens/signup/signup.dart';
import 'package:reading_space/states/currentUser.dart';
import 'package:reading_space/widgets/OurContainer.dart';

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginUser(String email, String password, BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      if (await currentUser.loginUser(email, password)) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect Login Info!'),
            duration: Duration(seconds: 2),
          ),
        );
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
              loginUser(emailController.text, passwordController.text, context);
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
          )
        ],
      ),
    );
  }
}
