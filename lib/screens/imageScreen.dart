import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class imageScreen extends StatefulWidget {
  @override
  _imageScreenState createState() => _imageScreenState();
}

class _imageScreenState extends State<imageScreen> {
  File _imageFile;
  List<Face> _faces;
  bool isLoading = false;
  ui.Image _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        imagePick();
      },child: Icon(Icons.add_a_photo),),
      body: (_imageFile == null)
        ? Center(child: Text('No image selected'))
        : Center(
      child: FittedBox(
        child: SizedBox(
          width: _image!=null?_image.width.toDouble():20,
          height: _image!=null?_image.height.toDouble():20,
          child: CustomPaint(
            painter: FacePainter(_image, _faces),
          ),
        ),
      ),
    ),
    );
  }
  imagePick() async {
    final imageFile = await ImagePicker.pickImage(source:ImageSource.gallery);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(image);
    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
        _loadImage(imageFile);
      });
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then(
          (value) => setState(() {
        _image = value;
      }),
    );
  }

}


class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];

  FacePainter(this.image, this.faces) {
    for (var i = 0; i < faces.length; i++) {
      rects.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..color = Colors.yellow;

    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < faces.length; i++) {
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}