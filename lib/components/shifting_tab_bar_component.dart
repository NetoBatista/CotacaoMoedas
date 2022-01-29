import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class ShiftingTabBarComponent {
  List<ShiftingTab> tabs;
  TabController? tabController;
  ShiftingTabBarComponent({ required this.tabs, this.tabController });

  Widget build() {
    return ShiftingTabBar(tabs: tabs, 
                          brightness: Brightness.dark, 
                          labelFlex: 1,
                          color: Colors.transparent, 
                          controller: tabController,
                          labelStyle: TextStyle(color: Colors.green) );
  }
}