import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  void Function()? onPressed;
  Widget? child;
  ButtonStyle? buttonStyle;
  ButtonComponent({ Key? key, required this.onPressed, required this.child, this.buttonStyle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child, style: buttonStyle,);
  }
}