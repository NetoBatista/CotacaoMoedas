import 'package:flutter/material.dart';

class SingleChildScrollViewComponent extends StatelessWidget {
  Widget child;
  SingleChildScrollViewComponent({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: child);
  }
}
