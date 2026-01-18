import 'package:flutter/cupertino.dart';
class MyCalenderProvider extends ChangeNotifier{
  // My Calender
  bool isPost = false;
  int? tabIndex=0;
  myCalendertoggle(val){
    tabIndex = val;
    notifyListeners();
  }
}