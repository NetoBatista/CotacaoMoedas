import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComponent extends StatelessWidget {
  TextEditingController textEditingController;
  IconData? iconData;
  String? hintText;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  int? maxLength;
  bool? readOnly;
  TextStyle? textStyle;
  void Function()? onTap;
  void Function(String)? onChange;

  TextFieldComponent({Key? key, this.onChange, this.onTap, required this.textEditingController, this.iconData, this.hintText, this.inputFormatters, this.keyboardType, this.maxLength, this.readOnly, this.textStyle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? iconText = iconData == null ? null : Icon(iconData);
    var decoration = InputDecoration(prefixIcon: iconText, border: const UnderlineInputBorder(), hintText: hintText);
    return TextField(onChanged: onChange, onTap: onTap, style: textStyle, readOnly: readOnly ?? false, controller: textEditingController, decoration: decoration, keyboardType: keyboardType, inputFormatters: inputFormatters, maxLength: maxLength,);
  }
}
