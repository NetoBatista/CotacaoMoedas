import 'package:flutter/material.dart';

class ColumnComponent extends StatelessWidget {
  List<Widget> children;
  CrossAxisAlignment? crossAxisAlignment;
  MainAxisAlignment? mainAxisAlignment;
  ColumnComponent({ Key? key, required this.children, this.crossAxisAlignment, this.mainAxisAlignment }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
                   children: children,
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start);
  }
}