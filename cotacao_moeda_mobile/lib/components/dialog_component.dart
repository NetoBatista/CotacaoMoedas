import 'package:cotacao_moeda/components/alert_dialog_component.dart';
import 'package:flutter/material.dart';

class DialogComponent {
  Widget child;
  BuildContext context;
  String? title;
  DialogComponent(this.child, this.context, this.title){
    showDialog(context: context, builder: (BuildContext context) => AlertDialogComponent(content: child, title: title), barrierDismissible: false);
  }
}
