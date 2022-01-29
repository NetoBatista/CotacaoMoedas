import 'package:cotacao_moeda/app_module.dart';
import 'package:cotacao_moeda/components/material_component.dart';
import 'package:cotacao_moeda/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialAppComponent(homeWidget: HomePage());
  }
}