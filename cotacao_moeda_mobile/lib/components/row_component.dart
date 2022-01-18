import 'package:flutter/material.dart';

class RowComponent extends StatelessWidget {
  List<Widget> children;
  MainAxisAlignment? mainAxisAlignment;
  CrossAxisAlignment? crossAxisAlignment;
  RowComponent({ Key? key, required this.children, this.mainAxisAlignment, this.crossAxisAlignment }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(children: children, 
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start);
  }
}