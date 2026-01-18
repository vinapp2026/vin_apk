
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_text.dart';
class CustomTab extends StatelessWidget {
   CustomTab({
     this.icon,
     this.index,
     this.iconSize,
     Key? key}):super(key: key);
   String? icon;
   double? iconSize;
   int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //icon
          Image.asset(
            icon!,scale: iconSize,
            color:Provider.of<MainProvider>(context).controller!.index==index?blueColor: blueColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
