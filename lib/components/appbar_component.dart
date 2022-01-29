import 'package:flutter/material.dart';

class AppBarComponent {
  Widget title;
  Color? color;
  AppBarComponent({required this.title, this.color });

  AppBar build() {
    return AppBar(title: title, backgroundColor: color);
  }
}
