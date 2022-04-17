import 'package:cotacao_moeda/components/button_component.dart';
import 'package:cotacao_moeda/components/center_component.dart';
import 'package:cotacao_moeda/components/column_component.dart';
import 'package:cotacao_moeda/components/container_component.dart';
import 'package:cotacao_moeda/components/date_picker_component.dart';
import 'package:cotacao_moeda/components/dropdown_component.dart';
import 'package:cotacao_moeda/components/dropdown_menu_item_component.dart';
import 'package:cotacao_moeda/components/icon_buttom_component.dart';
import 'package:cotacao_moeda/components/image_component.dart';
import 'package:cotacao_moeda/components/list_view_build_component.dart';
import 'package:cotacao_moeda/components/ocurrence_component.dart';
import 'package:cotacao_moeda/components/ocurrence_loading_component.dart';
import 'package:cotacao_moeda/components/row_component.dart';
import 'package:cotacao_moeda/components/single_child_scroll_view_component.dart';
import 'package:cotacao_moeda/components/skelton_component.dart';
import 'package:cotacao_moeda/components/text_component.dart';
import 'package:cotacao_moeda/components/text_field_component.dart';
import 'package:cotacao_moeda/components/visibility_component.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:cotacao_moeda/view/sequential_page/sequential_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class SequentialPage extends StatefulWidget {
  const SequentialPage({ Key? key }) : super(key: key);

  @override
  _SequentialPageState createState() => _SequentialPageState();
}

class _SequentialPageState extends State<SequentialPage> with AutomaticKeepAliveClientMixin<SequentialPage> {
  final SequentialPageController _sequentialPageController = Modular.get<SequentialPageController>();

  @override
  void initState() {
    _sequentialPageController.init();
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
                ContainerComponent(padding: EdgeInsets.only(top: 8, right: 10), child: buildDropDown()),
                Expanded(child: TextFieldComponent(textEditingController: _sequentialPageController.countSequentialController, 
                                                   hintText: "Sequência", 
                                                   onChange: (String newValue){
                                                     _sequentialPageController.verifyCanBeSearch();
                                                   },
                                                   keyboardType: TextInputType.number,
                                                   maxLength: 3,
                                                   inputFormatters: [ FilteringTextInputFormatter.digitsOnly ],
                                                   textStyle: TextStyle(fontSize: 14),)),
                buildButtonSearch()
              ],
            ),
          ),
          VisibilityComponent(isVisible: !_sequentialPageController.getOcurrence.value, child: buildListOcurrence()),
      ]),
    ));
  }

  Widget buildListOcurrence(){
    return ValueListenableBuilder<bool>(
      valueListenable: _sequentialPageController.getOcurrence,
      builder: (BuildContext context, bool value, Widget? widget) {
        
        if(_sequentialPageController.getOcurrence.value){
          return OcurrenceLoadingComponent();
        }
        
        if(_sequentialPageController.listAllOcurrence.isEmpty){
          return ContainerComponent();
        }

        return ContainerComponent(
          padding: EdgeInsets.only(top: 20),
          child: ListViewBuilderComponent(
            count: _sequentialPageController.listAllOcurrence.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index){
              var ocurrenceModel = _sequentialPageController.listAllOcurrence.elementAt(index);
              return ContainerComponent(padding: EdgeInsets.only(top: 10), 
                                        child: ColumnComponent(
                                          children: [
                                            CenterComponent(child: TextComponent(textStyle: TextStyle(fontSize: 16), text:  DateFormat("dd/MM/yyyy HH:mm:ss", "ptBR").format(DateTime.fromMillisecondsSinceEpoch(int.parse(ocurrenceModel.timeStamp) * 1000)))),
                                            SizedBox(height: 10,),
                                            OcurrenceComponent(_sequentialPageController.coinSelected as CoinModel,ocurrenceModel),
                                          ],
                                        ));
            }),
        );
    });
  }

  Widget buildStartMonth(){
    return Expanded(child: TextFieldComponent(textEditingController: _sequentialPageController.startMonthController, 
                    hintText: "Janeiro de 2020", 
                    onTap: (){
                      DatePickerComponent(context, (DateTime dateSelected){
                        _sequentialPageController.startDateSelected = dateSelected;
                        _sequentialPageController.startMonthController.text = "${DateFormat("dd MMMM", "ptBR").format(dateSelected).toUpperCase()} DE ${dateSelected.year}";
                        _sequentialPageController.verifyCanBeSearch();
                      }, DatePickerMode.day);
                    },
                    readOnly: true,
                    textStyle: TextStyle(fontSize: 14),));
  }

  Widget buildEndMonth(){
    return Expanded(child: TextFieldComponent(textEditingController: _sequentialPageController.endMonthController, 
                    hintText: "Dezembro de 2020", 
                    onTap: (){
                      DatePickerComponent(context, (DateTime dateSelected){
                        _sequentialPageController.endDateSelected = dateSelected;
                        _sequentialPageController.endMonthController.text = "${DateFormat("dd MMMM", "ptBR").format(dateSelected).toUpperCase()} DE ${dateSelected.year}";
                        _sequentialPageController.verifyCanBeSearch();
                      }, DatePickerMode.day);
                    },
                    readOnly: true,
                    textStyle: TextStyle(fontSize: 14)));
  }

  Widget buildButtonSearch(){
    return ValueListenableBuilder<bool>(
      valueListenable: _sequentialPageController.canBeSearch,
      builder: (BuildContext context, bool value, Widget? widget) {
        return ContainerComponent(padding: EdgeInsets.only(left: 20), 
                                  child: IconButtonComponent(onPressed: !_sequentialPageController.canBeSearch.value ? null : (){
                                                              _sequentialPageController.getSequentialOcurrence();
                                                            }, icon: Icon(Icons.search, color: !_sequentialPageController.canBeSearch.value ? Colors.grey : Colors.green)));
      });
    
  }

  Widget buildDropDown(){
    return ValueListenableBuilder<bool>(
      valueListenable: _sequentialPageController.getCoins,
      builder: (BuildContext context, bool value, Widget? widget) {
        return RowComponent(
            children: [
              VisibilityComponent(isVisible: !_sequentialPageController.getCoins.value,
               child: ValueListenableBuilder<DateTime>(
                      valueListenable: _sequentialPageController.refreshDropDown,
                      builder: (BuildContext context, DateTime value, Widget? widget) { 
                        return DropDownComponent(items: getDropDownMenuItemList(),
                                                value: _sequentialPageController.coinSelected,
                                                hint: TextComponent(text: "Escolha a moeda"),
                                                onChanged: (dynamic value) {
                                                  _sequentialPageController.coinSelected = value;
                                                  _sequentialPageController.verifyCanBeSearch();
                                                  _sequentialPageController.refreshDropDown.value = DateTime.now();
                                                });
                      })),
              VisibilityComponent(isVisible: _sequentialPageController.getCoins.value, 
              child: ContainerComponent(padding: EdgeInsets.only(top: 10), child: SkeltonComponent(width: 200, height: 20,))),
            ],
        );
      });
    
  }
  
  List<DropdownMenuItem> getDropDownMenuItemList(){
    List<DropdownMenuItem> dropDownItemList = <DropdownMenuItem>[];

    for(var coin in _sequentialPageController.listAllCoin){
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