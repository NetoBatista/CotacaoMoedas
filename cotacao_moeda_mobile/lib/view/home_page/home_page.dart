import 'package:cotacao_moeda/components/scaffold_component.dart';
import 'package:cotacao_moeda/components/shifting_tab_bar_component.dart';
import 'package:cotacao_moeda/view/closing_page/closing_page.dart';
import 'package:cotacao_moeda/view/ocurrence_page.dart/ocurrence_page.dart';
import 'package:cotacao_moeda/view/sequential_page/sequential_page.dart';
import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: ScaffoldComponent(body: buildPageSelected(), customAppBar: buildShiftingTabBar())
    );
  }

  Widget buildShiftingTabBar(){
    return ShiftingTabBarComponent(
        tabs: <ShiftingTab>[
        ShiftingTab(
          icon: const Icon(Icons.attach_money, color: Colors.green),
          text: 'Moedas',
        ),
        ShiftingTab(
          icon: const Icon(Icons.close_fullscreen, color: Colors.green),
          text: 'Fechamento',
        ),
        ShiftingTab(
          icon: const Icon(Icons.auto_graph, color: Colors.green),
          text: 'Sequencial',
        ),
      ]).build();
  }

  Widget buildPageSelected(){
    return TabBarView(
        children: <Widget>[
          OcurrencePage(),
          ClosingPage(),
          SequentialPage()
        ],
      );
  }
}