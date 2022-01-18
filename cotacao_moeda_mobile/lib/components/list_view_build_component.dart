import 'package:flutter/material.dart';

class ListViewBuilderComponent extends StatelessWidget {
  Widget Function(BuildContext, int) itemBuilder;
  int count;
  ScrollPhysics? physics;
  ListViewBuilderComponent({ Key? key, required this.itemBuilder, required this.count, this.physics }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: itemBuilder, itemCount: count, physics: physics, shrinkWrap: true);
  }
}
