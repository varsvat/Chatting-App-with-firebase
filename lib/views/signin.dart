import 'package:chat/helper/sharedpref.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatroomsscreen.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final authmethodssignin = new AuthMethods();

  final key = GlobalKey<FormState>();
  TextEditingController emailcontrollersignin = new TextEditingController();
  TextEditingController passwordcontrollersignin = new TextEditingController();

  bool isLoading = false;

  signInButton() async {
    if (key.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authmethodssignin
          .signInWithEmailandPassword(
              emailcontrollersignin.text, passwordcontrollersignin.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailcontrollersignin.text);

          SharedPreferncesFunctions.saveUserLoggedInSharedPreference(true);
          SharedPreferncesFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          SharedPreferncesFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, "Chatting App Login"),
      body: (isLoading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 100),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Form(
                              key: key,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (val) {
                                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val)
                                          ? null
                                          : "Please enter a valid Email address";
                                    },
                                    controller: emailcontrollersignin,
                                    style: TextStyle(color: Colors.white60),
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white70)),
                                        hintText: 'Enter Your Email Here......',
                                        hintStyle: textstyle(Colors.white54)),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "The Password Cannot be Empty";
                                      } else if (val.length < 6) {
                                        return "The Length of the Password must be greater than six Characters";
                                      }
                                    },
                                    controller: passwordcontrollersignin,
                                    style: TextStyle(color: Colors.white60),
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white70)),
                                        hintText:
                                            'Enter Your Password Here......',
                                        hintStyle: textstyle(Colors.white54)),
                                  ),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Forgot Password ?',
                            textAlign: TextAlign.end,
                            style: textstyle(Colors.white70)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30)),
                          color: Colors.blueGrey[800],
                          onPressed: () {
                            signInButton();
                          },
                          child: Text(
                            "Sign In",
                            style: textstyle(Colors.white70),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30)),
                          color: Colors.blueGrey[800],
                          onPressed: () {},
                          child: Text(
                            "Sign In With Google",
                            style: textstyle(Colors.white70),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Dont Have An Account ?",
                            style: textstyle(Colors.white70),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(" Click Here",
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
