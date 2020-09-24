import 'dart:io';
import 'dart:async';
import 'package:chat_app/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  var error="";
  bool load=false;
  final GlobalKey<ScaffoldState> rkey=GlobalKey<ScaffoldState>();
  var email=TextEditingController();
  var pass=TextEditingController();
  var cpass=TextEditingController();
  var username=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final key1=GlobalKey<FormState>();

    return Scaffold(
      key: rkey,
        appBar: AppBar(
          title: Text("Register",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red.shade200,Colors.red.shade800],begin: Alignment.topCenter,end: Alignment.bottomCenter)
                ),
              ),
                 Center(
                   child: Container(
                     alignment: Alignment.center,
                    height: double.infinity,
                    width: 300,
                    child: Form(
                        key:key1,child: ListView(
                      children: <Widget>[
                        SizedBox(height: 40.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: "Enter your username",
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.person,color: Colors.white,),
                            labelText: "Username",
                          ),
                          controller: username,
                          keyboardType: TextInputType.text,
                          validator: (val)=>val.isEmpty?"Enter a username":null,
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: "Enter your email",
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.email,color: Colors.white,),
                            labelText: "Email",
                          ),
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val)=>val.isEmpty?"Enter a email":null,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: pass,
                          decoration: InputDecoration(
                            labelText: "Enter password",
                            labelStyle: TextStyle(color: Colors.white
                            ),
                              hintStyle: TextStyle(color: Colors.black),
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock,color: Colors.white,)
                          ),
                          obscureText: true,
                          validator: (val){
                            return val.length>=6?null:"Enter a password of atleast 6 characters";},
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Confirm password",
                            prefixIcon: Icon(Icons.lock,color: Colors.white,),
                            labelStyle: TextStyle(color: Colors.white
                            ),
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: "Re-enter your password",
                          ),
                          obscureText: true,
                          controller: cpass,
                          validator: (val){
                            return val==pass.text?null:"Both passwords are different";},
                        ),
                        SizedBox(height: 40.0,),
                        if(load==false)
                        RaisedButton(
                          color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        onPressed: (){
                          if(key1.currentState.validate()){
                            setState(() {
                              load=true;
                            });
                            reg();
                          }
                          }
                        ,child: Text("Sign Up",style: TextStyle(color: Colors.red,letterSpacing: 1.5),),)
                        else
                          SpinKitWave(size: 40,color: Colors.white,),
                      ],
                    )
                    ),

              ),
                 ),
            ],
          ),
        ),

    );
  }
  void reg() async {


 /* int n=0;
  Firestore.instance.collection("info").snapshots().listen((event) {
    for (int i = 0; i < event.documents.length; i++) {
      if (username.text == event.documents[i]["username"]) {
        setState(() {
          load = false;
          n=-1;
        });
        if(n==0){
          print(1/0);
        }
        rkey.currentState.showSnackBar(
            SnackBar(content: Text("This username is already taken",),duration: Duration(seconds: 5),));
      }
    }
  });

  */


      try {
        AuthResult u = await a.createUserWithEmailAndPassword(
            email: email.text, password: pass.text);
        FirebaseUser user = u.user;
        Firestore.instance.collection("info").document(user.uid).setData({
          "username": username.text
        });
        sleep(Duration(seconds: 1));
        load = false;
        Navigator.pop(context);
      }
      catch (e) {
        email.text = "";
        pass.text = "";
        setState(() {
          load = false;
        });
        rkey.currentState.showSnackBar(SnackBar(content: Text(
          "Email already exists", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,));
      }
    }
  }

