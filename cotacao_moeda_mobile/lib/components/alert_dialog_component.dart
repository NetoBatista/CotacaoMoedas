import 'package:cotacao_moeda/components/text_component.dart';
import 'package:flutter/material.dart';

class AlertDialogComponent extends StatelessWidget {
  String? title;
  Widget content;
  AlertDialogComponent({Key? key, this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(shape: getBorder(),
                       title: title == null ? null : TextComponent(text: title.toString()),
                       content: content);
  }

  RoundedRectangleBorder getBorder(){
    const radius = Radius.circular(15.0);
    const border = BorderRadius.all(radius);
    const roundedBorder = RoundedRectangleBorder(borderRadius: border);
    return roundedBorder;
  }
}
