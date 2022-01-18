import 'package:flutter/material.dart';

class DropDownMenuItemComponent{
  Widget child;
  dynamic value;
  bool? enabled;
  DropDownMenuItemComponent({ required this.child, required this.value, this.enabled });

  DropdownMenuItem build() {
    return DropdownMenuItem(child: child, value: value, enabled: enabled ?? true);
  }
}
