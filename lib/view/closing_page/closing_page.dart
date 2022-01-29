import 'package:cotacao_moeda/components/button_component.dart';
import 'package:cotacao_moeda/components/center_component.dart';
import 'package:cotacao_moeda/components/column_component.dart';
import 'package:cotacao_moeda/components/container_component.dart';
import 'package:cotacao_moeda/components/dropdown_component.dart';
import 'package:cotacao_moeda/components/dropdown_menu_item_component.dart';
import 'package:cotacao_moeda/components/image_component.dart';
import 'package:cotacao_moeda/components/list_view_build_component.dart';
import 'package:cotacao_moeda/components/month_picker_component.dart';
import 'package:cotacao_moeda/components/ocurrence_component.dart';
import 'package:cotacao_moeda/components/ocurrence_loading_component.dart';
import 'package:cotacao_moeda/components/row_component.dart';
import 'package:cotacao_moeda/components/single_child_scroll_view_component.dart';
import 'package:cotacao_moeda/components/skelton_component.dart';
import 'package:cotacao_moeda/components/text_component.dart';
import 'package:cotacao_moeda/components/text_field_component.dart';
import 'package:cotacao_moeda/components/visibility_component.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:cotacao_moeda/view/closing_page/closing_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class ClosingPage extends StatefulWidget {
  const ClosingPage({ Key? key }) : super(key: key);

  @override
  _ClosingPageState createState() => _ClosingPageState();
}

class _ClosingPageState extends State<ClosingPage> with AutomaticKeepAliveClientMixin<ClosingPage> {
  final ClosingPageController _closingPageController = Modular.get<ClosingPageController>();

  @override
  void initState() {
    _closingPageController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage(){
    return SingleChildScrollViewComponent(
      child: ContainerComponent(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
        child: ColumnComponent(
        children: [
          ContainerComponent(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RowComponent(
              children: [
                buildStartMonth(),
                ContainerComponent(padding: EdgeInsets.only(top: 20, left: 10, right: 10), child: TextComponent(text: "até")),
                buildEndMonth(),
              ]),
          ),
          ContainerComponent(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: RowComponent(
              children: [
                buildDropDown(),
                buildButtonSearch()
              ],
            ),
          ),
          VisibilityComponent(isVisible: !_closingPageController.getOcurrence.value, child: buildListOcurrence()),
      ]),
    ));
  }

  Widget buildListOcurrence(){
    return ValueListenableBuilder<bool>(
      valueListenable: _closingPageController.getOcurrence,
      builder: (BuildContext context, bool value, Widget? widget) {
        
        if(_closingPageController.getOcurrence.value){
          return OcurrenceLoadingComponent();
        }
        
        if(_closingPageController.listAllOcurrence.isEmpty){
          return ContainerComponent();
        }

        return ContainerComponent(
          padding: EdgeInsets.only(top: 20),
          child: ListViewBuilderComponent(
            count: _closingPageController.listAllOcurrence.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index){
              var ocurrenceModel = _closingPageController.listAllOcurrence.elementAt(index);
              return ContainerComponent(padding: EdgeInsets.only(top: 10), 
                                        child: ColumnComponent(
                                          children: [
                                            CenterComponent(child: TextComponent(textStyle: TextStyle(fontSize: 16), text:  DateFormat("dd/MM/yyyy HH:mm:ss", "ptBR").format(DateTime.fromMillisecondsSinceEpoch(int.parse(ocurrenceModel.timeStamp) * 1000)))),
                                            OcurrenceComponent(_closingPageController.coinSelected as CoinModel,ocurrenceModel),
                                          ],
                                        ));
            }),
        );
    });
  }

  Widget buildStartMonth(){
    return Expanded(child: TextFieldComponent(textEditingController: _closingPageController.startMonthController, 
                    hintText: "Janeiro de 2020", 
                    onTap: (){
                      MonthPickerComponent(context, (DateTime dateSelected){
                        _closingPageController.startDateSelected = dateSelected;
                        _closingPageController.startMonthController.text = "${DateFormat("MMMM", "ptBR").format(dateSelected).toUpperCase()} DE ${dateSelected.year}";
                        _closingPageController.verifyCanBeSearch();
                      });
                    },
                    readOnly: true,
                    textStyle: TextStyle(fontSize: 14),));
  }

  Widget buildEndMonth(){
    return Expanded(child: TextFieldComponent(textEditingController: _closingPageController.endMonthController, 
                    hintText: "Dezembro de 2020", 
                    onTap: (){
                      MonthPickerComponent(context, (DateTime dateSelected){
                        _closingPageController.endDateSelected = dateSelected;
                        _closingPageController.endMonthController.text = "${DateFormat("MMMM", "ptBR").format(dateSelected).toUpperCase()} DE ${dateSelected.year}";
                        _closingPageController.verifyCanBeSearch();
                      });
                    },
                    readOnly: true,
                    textStyle: TextStyle(fontSize: 14)));
  }

  Widget buildButtonSearch(){
    return ValueListenableBuilder<bool>(
      valueListenable: _closingPageController.canBeSearch,
      builder: (BuildContext context, bool value, Widget? widget) {
        return ContainerComponent(padding: EdgeInsets.only(left: 20), 
                                  child: ButtonComponent(child: TextComponent(text: "Pesquisar"), 
                                                        onPressed: !_closingPageController.canBeSearch.value ? null : (){
                                                          _closingPageController.getClosingOcurrence();
                                                        }));
      });
    
  }

  Widget buildDropDown(){
    return ValueListenableBuilder<bool>(
      valueListenable: _closingPageController.getCoins,
      builder: (BuildContext context, bool value, Widget? widget) {
        return RowComponent(
            children: [
              VisibilityComponent(isVisible: !_closingPageController.getCoins.value,
               child: ValueListenableBuilder<DateTime>(
                      valueListenable: _closingPageController.refreshDropDown,
                      builder: (BuildContext context, DateTime value, Widget? widget) { 
                        return DropDownComponent(items: getDropDownMenuItemList(),
                                                value: _closingPageController.coinSelected,
                                                hint: TextComponent(text: "Escolha a moeda"),
                                                onChanged: (dynamic value) {
                                                  _closingPageController.coinSelected = value;
                                                  _closingPageController.verifyCanBeSearch();
                                                  _closingPageController.refreshDropDown.value = DateTime.now();
                                                });
                      })),
              VisibilityComponent(isVisible: _closingPageController.getCoins.value, 
              child: ContainerComponent(padding: EdgeInsets.only(top: 10), child: SkeltonComponent(width: 200, height: 20,))),
            ],
        );
      });
    
  }
  
  List<DropdownMenuItem> getDropDownMenuItemList(){
    List<DropdownMenuItem> dropDownItemList = <DropdownMenuItem>[];

    for(var coin in _closingPageController.listAllCoin){
      var dropDownItem = DropDownMenuItemComponent(
        child: RowComponent(children: [
            ImageComponent(uri: coin.image, width: 20, height: 20),
            ContainerComponent(padding: EdgeInsets.only(left: 10), child: TextComponent(text: coin.description)),
        ]), 
        value: coin).build();

      dropDownItemList.add(dropDownItem);
    }

    return dropDownItemList;
  }

  @override
  bool get wantKeepAlive => true;
}