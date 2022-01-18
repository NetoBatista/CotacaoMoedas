import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthPickerComponent {
  MonthPickerComponent(BuildContext context, dynamic Function(DateTime) onConfirm){
    showMonthPicker(
        context: context,
        locale: const Locale('pt', 'BR'),
        lastDate: DateTime.now(),
        firstDate: DateTime(2000,1,1),
        initialDate: DateTime.now()).then((DateTime? value) {
          if(value != null){
              onConfirm(value);
        }});
  }

}