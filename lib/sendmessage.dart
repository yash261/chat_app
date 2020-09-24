import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SendMessage extends StatefulWidget {
  final id;
  SendMessage(this.id);
  @override
  _SendMessageState createState() => _SendMessageState();
}
String msg="";
var m=TextEditingController();
class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(child: TextField(controller: m,onChanged: (val) {
            setState(() {
              msg = val;
            });
          },
            decoration: InputDecoration(
                labelText: "Send Message", border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.blue, width: 10)
            )),)),
          IconButton(onPressed: msg
              .trim()
              .isEmpty ? null : send
            ,
            icon: Icon(Icons.send, color: Colors.red,),
            focusColor: Colors.red.shade800,)
        ],
      ),

    );
  }

  void send() async{
    print(msg);
    await Firestore.instance.collection("chat").add({"message":msg,"time":Timestamp.now(),"id":widget.id});
    setState(() {
      m.text="";
      msg="";
    });
    FocusScope.of(context).unfocus();
  }
}