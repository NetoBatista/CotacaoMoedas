import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  void Function()? onPressed;
  Icon icon;

  IconButtonComponent({Key? key, this.onPressed, required this.icon }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: icon);
  }
}
