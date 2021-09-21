import 'dart:io';

import 'package:flutter/material.dart';

class ImageShow extends StatefulWidget {
  final File image;

  const ImageShow({Key key, this.image}) : super(key: key);
  @override
  _ImageShowState createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(tag: 'show Image', child: Image.file(widget.image)),
      ),
    );
  }
}