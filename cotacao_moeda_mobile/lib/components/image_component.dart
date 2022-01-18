import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  String uri;
  double? height;
  double? width;
  BoxFit? fit;
  ImageComponent({ Key? key, required this.uri, this.height, this.width, this.fit }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(uri, height: height, width:  width, fit: fit);
  }
}