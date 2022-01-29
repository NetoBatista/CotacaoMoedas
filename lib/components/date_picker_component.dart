import 'package:flutter/material.dart';

class DatePickerComponent {
  DatePickerComponent(BuildContext context, dynamic Function(DateTime) onConfirm, DatePickerMode datePickerMode){
    showDatePicker(
        context: context,
        locale: const Locale('pt', 'BR'),
        lastDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 730)),
        initialDate: DateTime.now(),
        initialDatePickerMode: datePickerMode).then((DateTime? value) {
          if(value != null){
            onConfirm(value);
          }
    });
  }
}