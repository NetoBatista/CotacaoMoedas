import 'package:cotacao_moeda/components/container_component.dart';
import 'package:flutter/material.dart';

class DropDownComponent extends StatelessWidget {
  List<DropdownMenuItem<dynamic>> items;
  Function(dynamic)? onChanged;
  dynamic value;
  Widget? hint;

  DropDownComponent({Key? key, required this.items, required this.onChanged, this.value, this.hint }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(items: items,
                          onChanged: onChanged,
                          value: value,
                          underline: ContainerComponent(
                            height: 1,
                            color: Colors.grey,
                          ),
                          hint: hint,
                          elevation: 16,
                          iconSize: 24);
  }
}
