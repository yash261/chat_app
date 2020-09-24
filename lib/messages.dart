import 'package:chat_app/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Messages extends StatelessWidget {
  final uid;
  Messages(this.uid);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: update, builder: (context, s) {
      if(s.connectionState==ConnectionState.waiting){
        return CircularProgressIndicator();
      }
      int length() {
        try {
          return s.data.documents.length;
        }
        catch (e) {
          return 0;
        }
      }
      return ListView.builder(
        reverse: true,
          itemCount: length(), itemBuilder: (context, index) {
        var m = s.data.documents;
        return Center(child: Bubble(
          m[index]['message'],m[index]['id']==uid,m[index]["id"],key: ValueKey(m[index].documentID),));
      });
    });
  }
  Stream get update {
    //.document(uid).collection("message")
    return Firestore.instance.collection("chat").orderBy("time",descending: true).snapshots();
  }
}
