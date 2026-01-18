import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier{

var getStadiumId;
setStadiumId({int? stadiumId}){
  getStadiumId = stadiumId;
  print("stadium Id $getStadiumId");
  notifyListeners();
}
}