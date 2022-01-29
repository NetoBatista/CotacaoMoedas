import 'package:cotacao_moeda/components/column_component.dart';
import 'package:cotacao_moeda/components/container_component.dart';
import 'package:cotacao_moeda/components/gesture_detector_component.dart';
import 'package:cotacao_moeda/components/list_view_build_component.dart';
import 'package:cotacao_moeda/components/ocurrence_component.dart';
import 'package:cotacao_moeda/components/ocurrence_loading_component.dart';
import 'package:cotacao_moeda/components/single_child_scroll_view_component.dart';
import 'package:cotacao_moeda/components/text_field_component.dart';
import 'package:cotacao_moeda/components/visibility_component.dart';
import 'package:cotacao_moeda/view/ocurrence_page.dart/ocurrence_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OcurrencePage extends StatefulWidget {
  const OcurrencePage({ Key? key }) : super(key: key);

  @override
  _OcurrencePageState createState() => _OcurrencePageState();
}

class _OcurrencePageState extends State<OcurrencePage> with AutomaticKeepAliveClientMixin<OcurrencePage> {
  final OcurrencePageController _ocurrencePageController = Modular.get<OcurrencePageController>();

  @override
  void initState() {
    _ocurrencePageController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage(){
    return ValueListenableBuilder<bool>(
      valueListenable: _ocurrencePageController.searchOcurrence,
      builder: (BuildContext context, bool value, Widget? widget) {
        return SingleChildScrollViewComponent(
          child: ColumnComponent(
            children: [
              VisibilityComponent(isVisible: _ocurrencePageController.searchOcurrence.value, child: OcurrenceLoadingComponent()),
              buildSearchCoin(),
              VisibilityComponent(isVisible: !_ocurrencePageController.searchOcurrence.value, child: buildListOcurrence())
          ]),
        );
      }
    );
  }

  Widget buildSearchCoin(){
    return VisibilityComponent(
      isVisible: !_ocurrencePageController.searchOcurrence.value,
      child: ContainerComponent(
        padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
        child: TextFieldComponent(textEditingController: _ocurrencePageController.nameCoinController, hintText: "Pesquisar por moeda", onChange: _ocurrencePageController.filterCoinByName)),
    );
  }

  Widget buildListOcurrence(){
     return ValueListenableBuilder<DateTime>(
      valueListenable: _ocurrencePageController.refreshList,
      builder: (BuildContext context, DateTime value, Widget? widget) {
        return ListViewBuilderComponent(
          count: _ocurrencePageController.listCoinFiltered.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index){
            var coinModel = _ocurrencePageController.listCoinFiltered.elementAt(index);
            var ocurrenceModel = _ocurrencePageController.getOcurrenceByCoin(coinModel.name);
            return GestureDetectorComponent(onTap: (){
              Modular.to.pushNamed("/about_coin", arguments: coinModel);
            }, 
            child: ContainerComponent(padding: EdgeInsets.only(left: 5, right: 5, top: 10), child: OcurrenceComponent(coinModel,ocurrenceModel, heroTag: coinModel.name,)));
        });
      }
    );

   
  }

  @override
  bool get wantKeepAlive => true;
}