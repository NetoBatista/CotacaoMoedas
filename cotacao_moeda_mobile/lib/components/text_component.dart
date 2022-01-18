import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  String text;
  TextStyle? textStyle;
  TextAlign? textAlign;
  TextComponent({Key? key, required this.text, this.textStyle, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle, textAlign: textAlign);
  }
}
