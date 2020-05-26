import 'package:chat/helper/authenticate.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/views/search.dart';
import "package:flutter/material.dart";

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  bool isLoading = false;

  final authmethodschatroomscreen = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Chats",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: null),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  authmethodschatroomscreen.signOut();
                  setState(() {
                    isLoading = true;
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Authenticate()));
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Search()));
              }),
          onPressed: null),
    );
  }
}
