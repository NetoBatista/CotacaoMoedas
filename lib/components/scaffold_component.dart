import 'package:cotacao_moeda/controller/application_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ScaffoldComponent extends StatelessWidget {
  Widget body;
  dynamic customAppBar;
  ScaffoldComponent({Key? key, required this.body, required this.customAppBar }) : super(key: key);

  ApplicationController applicationController = Modular.get<ApplicationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar,
      body: body,
    );
  }
}
