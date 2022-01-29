import 'package:flutter/material.dart';

class GestureDetectorComponent extends StatelessWidget {
  void Function()? onTap;
  Widget child;
  GestureDetectorComponent({Key? key, this.onTap, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: child);
  }
}
