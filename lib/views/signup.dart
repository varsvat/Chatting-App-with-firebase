import 'package:chat/helper/sharedpref.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/chatroomsscreen.dart';
import 'package:chat/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  bool isLoading = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  signUpButton() async {
    if (formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authMethods
          .signUpWithEmailandPassword(
              emailcontroller.text, passwordcontroller.text)
          .then((result) {
        if (result != null) {
          Map<String, String> userDataMap = {
            "userName": usernamecontroller.text,
            "userEmail": emailcontroller.text
          };

          databaseMethods.addUserInfo(userDataMap);

          SharedPreferncesFunctions.saveUserLoggedInSharedPreference(true);
          SharedPreferncesFunctions.saveUserNameSharedPreference(
              usernamecontroller.text);
          SharedPreferncesFunctions.saveUserEmailSharedPreference(
              emailcontroller.text);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, "Chatting App SignUp"),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 100),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Form(
                          key: formkey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (val) {
                                  return val.isEmpty
                                      ? "The Username cannot be Empty"
                                      : null;
                                },
                                controller: usernamecontroller,
                                style: TextStyle(color: Colors.white60),
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white70)),
                                    hintText: 'Enter Your UserName Here......',
                                    hintStyle: textstyle(Colors.white54)),
                              ),
                              TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Please enter a valid Email address";
                                },
                                controller: emailcontroller,
                                style: TextStyle(color: Colors.white60),
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white70)),
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
                                controller: passwordcontroller,
                                style: TextStyle(color: Colors.white60),
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white70)),
                                    hintText: 'Enter Your Password Here......',
                                    hintStyle: textstyle(Colors.white54)),
                              ),
                            ],
                          )),
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
                            signUpButton();
                          },
                          child: Text(
                            "Sign Up",
                            style: textstyle(Colors.white70),
                          ),
                        ),
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
                          onPressed: () {},
                          child: Text(
                            "Sign Up With Google",
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
                            "Already Have An Account ?",
                            style: textstyle(Colors.white70),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("Login Here",
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
