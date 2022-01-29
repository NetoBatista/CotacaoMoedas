import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  String uri;
  double? height;
  double? width;
  BoxFit? fit;
  String? heroTag;
  ImageComponent({ Key? key, required this.uri, this.height, this.width, this.fit, this.heroTag }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(heroTag != null){
      return Hero(tag: heroTag.toString(), child: Image.asset(uri, height: height, width:  width, fit: fit));
    }
    return Image.asset(uri, height: height, width:  width, fit: fit);
  }
}