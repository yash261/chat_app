
import 'package:chat_app/main.dart';
import 'package:chat_app/messages.dart';
import 'package:chat_app/screens/imageScreen.dart';
import 'package:chat_app/sendmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chatscreen extends StatefulWidget {
  FirebaseUser user;
  chatscreen(this.user);
  @override
  _chatscreenState createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  var msg;
  GlobalKey<ScaffoldState> st = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    print(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: st,
      /*floatingActionButton: FloatingActionButton(child: Icon(Icons.add_a_photo),onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>imageScreen()));

      },),

       */
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text("Chats"),
        actions: <Widget>[
          DropdownButton(items: [ DropdownMenuItem(child:
          //FlatButton.icon(icon:
          Row(
            children: <Widget>[
              Text("Logout"),
              SizedBox(width: 10,),
              Icon(Icons.exit_to_app),
            ],
          ), //,onPressed: (){
            //a.signOut();
            //},label: Text(""),),
            value: "logout",

          )
          ], onChanged: (val) {
            if (val == "logout") {
              a.signOut();
            }
          }, icon: Icon(Icons.more_vert),),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Messages(widget.user.uid),
          ),
         SendMessage(widget.user.uid),
        ],
      ),
    );
  }

}