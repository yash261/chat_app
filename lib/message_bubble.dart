import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Bubble extends StatelessWidget {
  final message;
  final isme;
  final UserId;
  final Key key;
  Bubble(this.message,this.isme,this.UserId,{this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isme?MainAxisAlignment.end:MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          decoration: BoxDecoration(
            color: isme?Colors.blue.shade700:Colors.redAccent.shade700,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isme?Radius.circular(0):Radius.circular(12),
              bottomRight: isme?Radius.circular(0):Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: isme?CrossAxisAlignment.center:CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(stream:Firestore.instance.collection("info").document(UserId).snapshots(),builder:(context,uname){
                try{
                  var name=uname.data;
                  if(!isme)
                 return  Text(name["username"],style: TextStyle(fontWeight: FontWeight.bold),);
                else
                  return Container();
                }catch(e){
                return Text("loading...");
    }
              }),
              SizedBox(height: 5,),
              Text(message,style: TextStyle(color: Colors.white,fontSize: 20,),textAlign: TextAlign.center,),
            ],
          ),
        ),
      ],
    );
  }
}
