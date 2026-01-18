import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/SharedPreferences/shared_preferences.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/provider/tabs_provider.dart';
import 'package:VIN/screens/homePage/profile_screen.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'MyCalender/calender_screen.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';
class HomePage extends StatefulWidget {
  int? index ;
  HomePage({
    this.index,
    Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  @override
  initState(){
    super.initState();
    Provider.of<MainProvider>(context,listen:false).tabFuncation(this);
    if(widget.index!=null) {
      Provider.of<MainProvider>(context, listen: false).tabNavigate(
          widget.index!,isInit: true);
    }
    AuthServices.getUserInfo();
  }

  int backPressCounter = 1;
  int backPressTotal = 2;
  bool? isOther=false;
  Future<bool> onWillPop() {
    int tbIndex = Provider.of<MainProvider>(context,listen: false).controller!.index;
    if(tbIndex == 0) {
      if (backPressCounter < 2) {
        Fluttertoast.showToast(msg: "Tap Again To Exit ");
        backPressCounter++;
        Future.delayed(
            const Duration(seconds: 1, milliseconds: 500), () {
          backPressCounter--;
        });
        return Future.value(false);
      } else {
        SystemNavigator.pop();
        return Future.value(true);
      }
    }else{
      Provider.of<MainProvider>(context,listen: false).tabNavigate(0);
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context){
    return CustomParentWidget(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: TabBarView(
            controller: Provider.of<MainProvider>(context).controller,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              CalenderScreen(),
              FavouriteScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 3,
            child: Container(
              height: 65,
              width: double.infinity,
              child: TabBar(
                  controller: Provider.of<MainProvider>(context).controller,
                  indicatorWeight: 0.1,
                  tabs: [
                    Tab(child: CustomTab(
                      icon: "assets/icons/ic_home.png",index:0,iconSize: 9,)),
                    Tab(child: CustomTab(icon: "assets/icons/ic_calendar.png",index: 1,iconSize: 3.4,)),
                    Tab(child: CustomTab(icon: "assets/icons/ic_heart.png",index:2,iconSize: 3.4,)),
                    Tab(child: CustomTab(icon: "assets/icons/ic_user.png",index:3,iconSize: 13,)),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
