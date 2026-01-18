import 'dart:ui';

import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/screens/PickLocation/custom_model_bottom_sheet.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
class PickLocationScreen extends StatelessWidget {
  bool? isHomeScreen;
   PickLocationScreen({
     this.isHomeScreen,
     Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset("assets/images/VIN_img.png",scale: 1,),
            //Space
            const SizedBox(height: 50,),
            //All Set
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              child: CustomText(
                title: "All Set",
                fontSize: 24,
                color: darkBlueColor,
              ),
            ),
            //Space
            SizedBox(height: 8,),
            //
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              child: CustomText(
                title: "Your Profile has been created",
                fontSize: 15,
                color: darkBlueColor,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child:    Container(
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
            child: CustomButton(
              onPressed: () {
                openBottom(context);
              },
              btnHeight: 48,
              btnRadius: 8,
              title: "Pick Location",
              fontWeight: FontWeight.w600,
              btnColor: kPrimaryColor,
              textColor: whiteColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
   void openBottom(BuildContext context) {
     showModalBottomSheet(
         isScrollControlled: true,
         backgroundColor: whiteColor,
         shape:  RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(18),
             topRight: Radius.circular(18),
           ),
         ),
         context: context, builder: (context){
       return    CustomModelBottomSheet(isHomeScreen: isHomeScreen,);
     });
   }
}
