
import 'package:cotacao_moeda/controller/application_controller.dart';
import 'package:cotacao_moeda/controller/request_controller.dart';
import 'package:cotacao_moeda/service/coin_service.dart';
import 'package:cotacao_moeda/service/ocurrence_service.dart';
import 'package:cotacao_moeda/service/shared_preference_service.dart';
import 'package:cotacao_moeda/view/about_coin_page/about_coin_page.dart';
import 'package:cotacao_moeda/view/about_coin_page/about_coin_page_controller.dart';
import 'package:cotacao_moeda/view/closing_page/closing_page_controller.dart';
import 'package:cotacao_moeda/view/home_page/home_page.dart';
import 'package:cotacao_moeda/view/ocurrence_page.dart/ocurrence_page_controller.dart';
import 'package:cotacao_moeda/view/sequential_page/sequential_page_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    //Controller
    Bind((i) => ApplicationController()),
    Bind((i) => RequestController()),

    //View Controller
    Bind((i) => OcurrencePageController()),
    Bind((i) => ClosingPageController()),
    Bind((i) => SequentialPageController()),
    Bind((i) => AboutCoinPageController()),
    
    //Services
    Bind((i) => CoinService()),
    Bind((i) => OcurrenceService()),
    Bind((i) => SharedPreferenceService()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const HomePage(), transition: defaultTransation()),
    ChildRoute('/about_coin', child: (context, args) => AboutCoinPage(args.data), transition: defaultTransation()),
  ];

  TransitionType defaultTransation() => TransitionType.fadeIn;
}