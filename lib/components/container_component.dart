import 'package:flutter/material.dart';

class ContainerComponent extends StatelessWidget {
  Widget? child;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  BoxDecoration? boxDecoration;
  double? width;
  double? height;
  Color? color;
  ContainerComponent({Key? key, this.child, this.padding, this.boxDecoration, this.width, this.height, this.color, this.margin }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: padding, child: child, decoration: boxDecoration, height: height, width: width, color: color, margin: margin,);
  }
}
