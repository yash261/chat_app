import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class logina extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<logina> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key=GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.grey.shade100,Colors.grey.shade800],begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
        child: Center(
          child: Card(margin: EdgeInsets.all(10),child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Form(
              key: key,
              child: Column(
                children: <Widget>[
                  FlatButton(onPressed: (){
                    if(key.currentState.validate()){

                    }
                  }, child: null)
                ],
              ),
            ),
          ),),
        ),
      ),
    );
  }
}
