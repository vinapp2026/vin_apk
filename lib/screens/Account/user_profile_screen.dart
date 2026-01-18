import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_chart.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
class UserProfileScreen extends StatelessWidget {
   UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: true);

    return CustomParentWidget(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              //Appbar
              Container(
                height: 80,
                padding: const EdgeInsets.only(left: 10,top: 20),
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
                        title: UserModel().username,
                        fontSize: 18,
                        color: darkBlueColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),  //
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Space
                      SizedBox(height: 40,),
                      //b
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          width: double.infinity,
                          height: 210,
                          decoration: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Column(
                            children: [
                              //img
                              Container(
                                height: 70,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    //img
                                    Positioned.directional(
                                      textDirection: Directionality.of(context),
                                      start: 0,
                                      end: 0,
                                      top: -36,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 110,
                                            height: 110,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 1,
                                                    color: blueColor
                                                ),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage("assets/images/profile_img.jpg")
                                                )
                                            ),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Positioned.directional(
                                                    textDirection: Directionality.of(context),
                                                    start: 0,
                                                    end: 0,
                                                    bottom: -13,
                                                    child: Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: blueColor2
                                                      ),
                                                      child: Center(
                                                        child: CustomText(
                                                          title: "24",
                                                          fontSize: 14,
                                                          color: whiteColor,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Space
                              SizedBox(height: 20,),
                              //User Name
                              Container(
                                alignment: Alignment.center,
                                child: CustomText(
                                  title: "User Name",
                                  fontSize: 16,
                                  color: whiteColor,
                                ),
                              ),
                              //Space
                              SizedBox(height: 20,),
                              //
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomInkWell(
                                        onTap: (){
                                          //    Helper.toScreen(context, BookingDetailScreen());
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: lightblueColor,
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              //
                                              Image.asset("assets/icons/ic_traced.png",scale: 0.9,color: blueColor,),
                                              //Space
                                              SizedBox(height: 5,),
                                              //
                                              CustomText(
                                                title: "220",
                                                fontSize: 16,
                                                color: blueColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Space
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: CustomInkWell(
                                        onTap: (){
                                          //    Helper.toScreen(context, BookingDetailScreen());
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: lightblueColor,
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  //
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset("assets/icons/ic_award.png",scale: 0.9,color: blueColor,),
                                                      //Space
                                                      SizedBox(width: 3,),
                                                      //
                                                      CustomText(
                                                        title: "Level",
                                                        fontSize: 10,
                                                        color: blueColor,
                                                      ),
                                                    ],
                                                  ),
                                                  //Space
                                                  SizedBox(height: 5,),
                                                  //
                                                  CustomText(
                                                    title: "Active",
                                                    fontSize: 16,
                                                    color: blueColor,
                                                  ),
                                                ],
                                              ),
                                              Positioned.directional(
                                                  textDirection: Directionality.of(context),
                                                  end: 12,
                                                  top: 7,
                                                  child: Image.asset("assets/icons/ic_info.png",))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //Space
                      SizedBox(height: 20,),
                      //card
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 16),
                      //   child: Card(
                      //     elevation: 3,
                      //     shape:  RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12)
                      //     ),
                      //     child: Container(
                      //       width: double.infinity,
                      //       height: 382,
                      //       padding: EdgeInsets.only(right: 12,top: 16,bottom: 16),
                      //       child: Row(
                      //         children: [
                      //           Expanded(
                      //             child: Container(
                      //               padding: EdgeInsets.only(right: 12),
                      //               child: Column(
                      //                 children: [
                      //                   Container(
                      //                     padding: EdgeInsets.only(left: 12),
                      //                     alignment: Alignment.centerLeft,
                      //                     child: CustomText(
                      //                       title: "My Skill Level",
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.w700,
                      //                       color: darkBlueColor,
                      //                     ),
                      //                   ),
                      //                   //Space
                      //                   SizedBox(height: 30,),
                      //                   //ProgressBar
                      //                   Row(
                      //                     children: [
                      //                       Expanded(
                      //                         child: LinearPercentIndicator(
                      //                           //width: 150.0,
                      //                           lineHeight: 44.0,
                      //                           percent: 0.7,
                      //                           backgroundColor: lightblueColor,
                      //                           progressColor: blueColor,
                      //                           barRadius: Radius.circular(8),
                      //                           center: CustomText(
                      //                             title: "Advanced",
                      //                             color: whiteColor,
                      //                             fontSize: 16,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   //Space
                      //                   SizedBox(height: 30,),
                      //                   //
                      //                   Container(
                      //                     padding: EdgeInsets.only(left: 12),
                      //                     child: Row(
                      //                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                       children: [
                      //                         Image.asset("assets/icons/ic_traced.png",color: blueColor,),
                      //                         //Space
                      //                         SizedBox(width: 8,),
                      //                         Expanded(
                      //                           child: Column(
                      //                             crossAxisAlignment: CrossAxisAlignment.start,
                      //                             children: [
                      //                               CustomText(
                      //                                 title: "Total Activities",
                      //                                 fontSize: 11,
                      //                                 color: darkBlueColor,
                      //                               ),
                      //                               //Space
                      //                               SizedBox(height: 8,),
                      //                               Container(
                      //                                 alignment: Alignment.centerLeft,
                      //                                 child: CustomText(
                      //                                   title: "220",
                      //                                   fontSize: 20,
                      //                                   fontWeight: FontWeight.w700,
                      //                                   color: darkBlueColor,
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //
                      //           Expanded(
                      //             child: Container(
                      //               height: double.infinity,
                      //               decoration: BoxDecoration(
                      //                   color: lightblueColor,
                      //                   borderRadius: BorderRadius.circular(12)
                      //               ),
                      //               padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                      //               child: Column(
                      //                 children: [
                      //                   //Activity Streak
                      //                   Container(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: CustomText(
                      //                       title: "Activity Streak",
                      //                       fontSize: 14,
                      //                       color: darkBlueColor,
                      //                     ),
                      //                   ),
                      //                   //Space
                      //                   SizedBox(height: 5,),
                      //                   CustomChart(),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
