import 'package:cotacao_moeda/components/card_component.dart';
import 'package:cotacao_moeda/components/container_component.dart';
import 'package:cotacao_moeda/components/list_view_build_component.dart';
import 'package:cotacao_moeda/components/row_component.dart';
import 'package:cotacao_moeda/components/skelton_component.dart';
import 'package:flutter/material.dart';

import 'column_component.dart';

class OcurrenceLoadingComponent extends StatelessWidget {
  const OcurrenceLoadingComponent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListViewBuilderComponent(
            count: 5, 
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index){
              return ContainerComponent(
                padding: EdgeInsets.all(5),
                child: CardComponent(
                  child: ContainerComponent(
                    padding: EdgeInsets.all(10),
                    child: RowComponent(
                      children: [
                        SkeltonComponent(width: 120, height: 120),
                        ColumnComponent(
                          children: [
                            ContainerComponent(padding: EdgeInsets.only(left: 30), child: SkeltonComponent(width: 120, height: 20)),                          
                            ContainerComponent(padding: EdgeInsets.only(top: 10, left: 30), child: SkeltonComponent(width: 120, height: 20)),
                            RowComponent(
                              children: [
                                ContainerComponent(padding: EdgeInsets.only(top: 10, left: 30), child: SkeltonComponent(width: 60, height: 20)),
                                ContainerComponent(padding: EdgeInsets.only(top: 10, left: 40), child: SkeltonComponent(width: 60, height: 20)),
                              ],
                            ),
                            RowComponent(
                              children: [
                                ContainerComponent(padding: EdgeInsets.only(top: 10, left: 30), child: SkeltonComponent(width: 60, height: 20)),
                                ContainerComponent(padding: EdgeInsets.only(top: 10, left: 40), child: SkeltonComponent(width: 60, height: 20)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}