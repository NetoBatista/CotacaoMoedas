import 'package:flutter/material.dart';

class VisibilityComponent extends StatelessWidget {
  Widget child;
  bool isVisible;
  VisibilityComponent({Key? key, required this.child, required this.isVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(child: child, visible: isVisible);
  }
}
