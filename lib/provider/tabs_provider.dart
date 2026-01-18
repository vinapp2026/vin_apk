
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TabsProvider extends ChangeNotifier{
  //
  TabController? signInTabController;
  signInTabFung(TickerProvider vsync){
    signInTabController = TabController(length: 2, vsync: vsync);
    signInTabController!.addListener(signInTabIndexChange);
  }
  signInTabIndexChange(){
    notifyListeners();
  }

}