import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
class LeaderboardScreen extends StatelessWidget {
   LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body:Column(
          children: [
            //Appbar
            Container(
              height: 110,
              padding: const EdgeInsets.only(left: 10,top: 15),
              child: Row(
                children: [
                  CustomInkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/icons/ic_back.png",color: darkBlueColor,),
                    ),
                  ),
                  //Space
                  SizedBox(width: 12,),
                  //
                  Expanded(
                    child: CustomText(
                      title: "Leader Board",
                      fontSize: 18,
                      color: darkBlueColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 10,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CustomInkWell(
                        onTap: (){
                          //        Helper.toScreen(context, CourtProfileScreen2());
                        },
                        child: Card(
                          elevation: 3,
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 12),
                            child: Row(
                              children: [
                                CustomText(
                                  title: "1",
                                  fontSize: 20,
                                  color: darkBlueColor,
                                ),
                                //Space
                                SizedBox(width: 12,),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/images/profile_img.jpg")
                                    ),
                                  ),
                                ),
                                //Space
                                SizedBox(width: 10,),
                                Expanded(
                                  child: CustomText(
                                    title: "Name one",
                                    fontSize: 18,
                                    color: darkBlueColor,
                                  ),
                                ),
                                //
                                Image.asset("assets/icons/ic_forward.png",color: greyColor,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
