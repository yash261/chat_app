import 'dart:io';
//import 'package:fire/register.dart';
import 'package:chat_app/screens/registerscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:chat_app/loading.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
class login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return l();
  }
}
GlobalKey<ScaffoldState> skey=GlobalKey<ScaffoldState>();
class l extends State<login> {
  bool load=false;
  int c=0;
  String error="";
  var email=TextEditingController();
  var pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final key=GlobalKey<FormState>();
    return Scaffold(
      key: skey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.red.shade200,Colors.red.shade800
                ],begin: Alignment.topCenter,end: Alignment.bottomCenter)
              ),
          ),
              Container(
                height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                child: Form(
                    key: key,
                    child: Column(
                  children: <Widget>[
                    Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 30,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (val)=>val.isEmpty?"Enter Email":null,
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,color: Colors.white,),
                        hintText: " Enter your email",
                          labelText: "Email",
                        contentPadding: EdgeInsets.only(top: 15),
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20.0,
                    ),
                    TextFormField(
                      validator: (val)=> val.isNotEmpty?null:"Enter correct password",
                      controller: pass,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.only(top: 14),
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock,color: Colors.white,),
                        hintText: " Enter your password"
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    if(load==false)
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 5,
                          onPressed: (){

                        if(key.currentState.validate()) {
                          anon();
                        }
                        }, child: Text("LOGIN",style: TextStyle(color: Colors.red,letterSpacing: 1.5),)),
                    )
                    else
                      CircularProgressIndicator(backgroundColor: Colors.white,),
                    SizedBox(height: 20.0,),
                    Container(
                      child: Text("-OR-",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                    SizedBox(height: 20,),
                    Text("Sign in with",style: TextStyle(color: Colors.white),),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        gsign();
                        },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                          image: DecorationImage(image: AssetImage("images/google.png")),
                          boxShadow: [BoxShadow(color: Colors.black,blurRadius: 6,)],
                          shape: BoxShape.circle
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> register()));
                      },
                      child: Text("Don't have an account? Sign Up",style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(height: 30,),
                 //   Text(error,style: TextStyle(color: Colors.red,),)
                  ],
                )
                ),
              ))
              ]
              ),
        ),


      );
  }

  void gsign()  async{
    //data.reference().child("message").push().set({"user":"checking","pass":"abcde"});
    setState(() {
      load=true;
    });
    GoogleSignInAccount ga=await g.signIn();
    GoogleSignInAuthentication gaa=await ga.authentication;
    final AuthCredential cr=GoogleAuthProvider.getCredential(idToken: gaa.idToken, accessToken: gaa.accessToken);
    setState(() {
      load=false;
    });
    AuthResult u=await a.signInWithCredential(cr);
    FirebaseUser user=u.user;
    Firestore.instance.collection("info").document(user.uid).setData({"username":user.displayName});
  }
  void anon() async{
    setState(() {
      load=true;
    });
    try {
      AuthResult u = await a.signInWithEmailAndPassword(
          email: email.text, password: pass.text);
      FirebaseUser user = u.user;

      setState(() {
        load=false;
        email.text="";
        pass.text="";
        error="";
        c=0;
      });
    }
    catch(PlatformException){
      setState(() {
        error="Wrong password/email";
        load=false;
        email.text="";
        c=1;
        pass.text="";
      });
      skey.currentState.showSnackBar(SnackBar(
        content: Text("Wrong password/email",
          style: TextStyle(color: Colors.white),),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.black,));
    }
    //AuthResult r= await a.signInAnonymously();
    //FirebaseUser user=r.user;
    //print((user.uid).toString());
  }
}
