import 'package:VIN/utilites/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_button.dart';
import 'custom_inkwell_btn.dart';
import 'custom_text.dart';

class CustomDialogue extends StatelessWidget {

  CustomDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 20,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Container(
             padding: EdgeInsets.symmetric(horizontal: 18,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   CustomInkWell(
                     onTap: (){
                       Navigator.pop(context);
                     },
                     child: Container(
                       padding: const EdgeInsets.all(5.0),
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: lightblueColor.withOpacity(0.3)
                       ),
                       child: Icon(Icons.clear,size: 20,color: lightblueColor,),
                     ),
                   )
                ],
              ),
            ),
            //space
            SizedBox(height: 6,),
            //
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              child: CustomText(
                title: "Received!",
                fontSize: 20,
                color: kPrimaryColor,
              ),
            ),

            //space
            SizedBox(height: 8,),
            //
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              child: CustomText(
                title: "Thank you for submitting your profile for approval."
                    " Your submission is being reviewed by the team"
                    " and you should get a status update within 24 hours.",
                fontSize: 15,
                color: kBlackColor,
                textAlign: TextAlign.center,
              ),
            ),
            //space
            SizedBox(height: 20,),
            //
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                btnHeight: 48,
                btnWidth: 200,
                btnRadius: 55,
                title: "Got it!",
                fontWeight: FontWeight.w600,
                btnColor: kPrimaryColor,
                textColor: whiteColor,
                fontSize: 18,
              ),
            ),
          ],
        )
      ),
    );
  }
}
