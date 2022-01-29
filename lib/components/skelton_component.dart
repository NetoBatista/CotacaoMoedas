import 'package:cotacao_moeda/components/container_component.dart';
import 'package:flutter/material.dart';

class SkeltonComponent extends StatelessWidget {
  final double height, width;
  SkeltonComponent({ Key? key, required this.height, required this.width }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerComponent(
      height: height,
      width: width,
      boxDecoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.all(Radius.circular(16)))
    );
  }
}