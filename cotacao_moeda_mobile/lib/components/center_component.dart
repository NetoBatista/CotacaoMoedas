import 'package:flutter/material.dart';

class CenterComponent extends StatelessWidget {
  Widget? child;
  CenterComponent({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: child);
  }
}
