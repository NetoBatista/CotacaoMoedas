import 'package:cotacao_moeda/controller/application_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MaterialAppComponent extends StatefulWidget {
  Widget homeWidget;
  MaterialAppComponent({Key? key, required this.homeWidget}) : super(key: key);

  @override
  _MaterialAppComponentState createState() => _MaterialAppComponentState();
}

class _MaterialAppComponentState extends State<MaterialAppComponent> {
  ApplicationController applicationController = Modular.get<ApplicationController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: applicationController.nameApp,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            primaryColor: Colors.green,
            visualDensity: VisualDensity.comfortable,
            brightness: Brightness.dark,
            toggleableActiveColor: Colors.green,
            accentColor: Colors.green,
            colorScheme: ColorScheme.fromSwatch(primaryColorDark: Colors.green, primarySwatch: Colors.green,brightness: Brightness.dark, accentColor: Colors.green),
          ),
          home: widget.homeWidget,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [
            Locale('pt', 'BR')
          ]
      ).modular();
  }
}
