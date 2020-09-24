import 'package:chat_app/screens/authscreen.dart';
import 'package:chat_app/screens/chatscreen.dart';
import 'package:chat_app/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

FirebaseAuth a=FirebaseAuth.instance;
GoogleSignIn g=GoogleSignIn();
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: decide(),
        //chatscreen(title: 'Chats'),
      ),
    );
  }
}
class decide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser u=Provider.of(context);
    print(u);
    return u==null?login():chatscreen(u);
  }
}
Stream<FirebaseUser> get user{
  return a.onAuthStateChanged;
}

