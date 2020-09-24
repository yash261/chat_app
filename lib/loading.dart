import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.red,
          size: 50.0,
        ),
      ),
    );
  }
}
