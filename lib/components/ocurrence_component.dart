import 'package:cotacao_moeda/components/card_component.dart';
import 'package:cotacao_moeda/components/column_component.dart';
import 'package:cotacao_moeda/components/container_component.dart';
import 'package:cotacao_moeda/components/image_component.dart';
import 'package:cotacao_moeda/components/row_component.dart';
import 'package:cotacao_moeda/components/text_component.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:cotacao_moeda/model/ocurrence_model.dart';
import 'package:flutter/material.dart';

class OcurrenceComponent extends StatelessWidget {
  CoinModel coinModel;
  OcurrenceModel ocurrenceModel;
  String? heroTag;
  OcurrenceComponent(this.coinModel, this.ocurrenceModel, { Key? key, this.heroTag }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardComponent(
                  child: ContainerComponent(
                    padding: EdgeInsets.all(10),
                    child: RowComponent(
                      children: [
                        ImageComponent(uri: coinModel.image, width: 120, height: 120, heroTag: heroTag,),
                        ColumnComponent(
                          children: [
                            ContainerComponent(padding: EdgeInsets.only(left: 10), child: TextComponent(text: coinModel.description, textStyle: TextStyle(fontSize: 16))),
                            ContainerComponent(padding: EdgeInsets.only(top: 10, left: 10,bottom: 10), child: TextComponent(text: ocurrenceModel.ask, textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                            RowComponent(
                              children: [
                                ContainerComponent(padding: EdgeInsets.only(top: 10, left: 10), child: TextComponent(text: "Variação: ")),
                                ContainerComponent(padding: EdgeInsets.only(top: 10), child: TextComponent(text: (ocurrenceModel.varBid), textStyle: TextStyle(fontWeight: FontWeight.bold))),
                                ContainerComponent(padding: EdgeInsets.only(top: 10, left: 10), child: TextComponent(text: "Máx: ")),
                                ContainerComponent(padding: EdgeInsets.only(top: 10), child: TextComponent(text: (ocurrenceModel.high), textStyle: TextStyle(fontWeight: FontWeight.bold))),
                              ],
                            ),
                            RowComponent(
                              children: [
                                ContainerComponent(padding: EdgeInsets.only(top: 10, left: 10), child: TextComponent(text: "Variação %: ")),
                                ContainerComponent(padding: EdgeInsets.only(top: 10), child: TextComponent(text: double.parse(ocurrenceModel.pctChange).toStringAsFixed(2), textStyle: TextStyle(fontWeight: FontWeight.bold))),
                                ContainerComponent(padding: EdgeInsets.only(top: 10, left: 10), child: TextComponent(text: "Mín: ")),
                                ContainerComponent(padding: EdgeInsets.only(top: 10), child: TextComponent(text: (ocurrenceModel.low), textStyle: TextStyle(fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
  }
}