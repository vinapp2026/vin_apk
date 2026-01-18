import 'dart:ui';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/SharedPreferences/shared_preferences.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/SignIn/signin_main_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_chart.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/edit_profile_screen.dart';
import '../Account/user_profile_screen.dart';
import '../leaderboard_screen.dart';
import 'CustomDrawer/custom_drawer.dart';
class ProfileScreen extends StatefulWidget {
   ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   logout(BuildContext context)async{
     Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
       SharedPreferences prefs = await SharedPreferences.getInstance();
       if (prefs.getInt("id") != null||prefs.getString("token")!=null){
         await prefs.setInt("id",0);
         await  prefs.setString("token","");
         SharedPreferencesService.setLatLngSharedPreferences(
           location: "",
           latitude: null,
           longitude: null,
         );
         UserModel().location="";
         UserModel().latitude=null;
         UserModel().longitude=null;
         if(prefs.getString("token")==null||prefs.getString("token")=="") {
           Helper.toRemoveUntiScreen(context, SignInMainScreen());
           Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
           Helper.showSnack(context, "Logout Successfully");
         }else {
           Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
           Helper.showSnack(context, "Logout Failed");
         }
       }
   }

   @override
  void initState() {
    super.initState();
  }
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body:  Container(
        child: Column(
          children: [
            //Appbar
            Container(
              height: 80,
              padding: const EdgeInsets.only(left: 10,top: 20,right: 18),
              child: Row(
                children: [
                  CustomInkWell(
                    onTap: (){
                      //    Navigator.pop(context);
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/icons/ic_menu2.png",color: darkBlueColor,),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Space
                    const SizedBox(height: 55,),
                    //b
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Container(
                        width: double.infinity,
                        height: 235,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            //img
                            Container(
                              height: 62,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  //img
                                  Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    start: 0,
                                    end: 0,
                                    top: -50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 110,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: CustomCachedNetworkImage(url: UserModel().img.toString(),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //edit
                                  Positioned.directional(
                                      textDirection: Directionality.of(context),
                                      end: 10,
                                      top: 10,
                                      child: CustomInkWell(
                                          onTap: ()async{
                                            await AuthServices.getUserInfo();
                                            Helper.toScreen(context, EditProfileScreen());
                                          },
                                          child: Image.asset("assets/icons/ic_edit.png",scale: 1.3,))
                                  )
                                ],
                              ),
                            ),
                            //User Name
                            Container(
                              alignment: Alignment.center,
                              child: CustomText(
                                title: UserModel().username,
                                fontSize: 16,
                                color: whiteColor,
                              ),
                            ),
                            //Space
                            const SizedBox(height: 20,),
                            //
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                            Image.asset("assets/icons/ic_traced.png",scale: 10,color: blueColor,),
                                            //Space
                                            const SizedBox(height: 5,),
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
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: CustomInkWell(
                                      onTap: (){
                                        //     Helper.toScreen(context, UserProfileScreen());
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
                                                    Image.asset("assets/icons/ic_award.png",scale: 3.5,color: blueColor,),
                                                    //Space
                                                    const SizedBox(width: 3,),
                                                    //
                                                    CustomText(
                                                      title: "Level",
                                                      fontSize: 10,
                                                      color: blueColor,
                                                    ),
                                                  ],
                                                ),
                                                //Space
                                                const SizedBox(height: 5,),
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
                                                child: Image.asset("assets/icons/ic_info.png",scale: 6,))
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
                    const SizedBox(height: 20,),
                    //Logout
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child:Provider.of<MainProvider>(context, listen: false).isLoading?const CupertinoActivityIndicator():  CustomButton(
                        onPressed: () {
                          logout(context);
                        },
                        btnHeight: 48,
                        btnRadius: 8,
                        title: "Log out",
                        fontWeight: FontWeight.w600,
                        btnColor: kPrimaryColor,
                        textColor: whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    //Space
                    // const SizedBox(height: 20,),
                    // //
                    // //card
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Card(
                    //     elevation: 3,
                    //     shape:  RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12)
                    //     ),
                    //     child: CustomInkWell(
                    //       onTap: (){
                    //      //   Helper.toScreen(context, LeaderboardScreen());
                    //       },
                    //       child: Container(
                    //         width: double.infinity,
                    //         padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                    //         child: Column(
                    //           children: [
                    //             //Leaderboard
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 CustomText(
                    //                   title: "Leaderboard",
                    //                   fontSize: 16,
                    //                   color: darkBlueColor,
                    //                 ),
                    //                 CustomInkWell(
                    //                   onTap: (){
                    //
                    //                   },
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: CustomText(
                    //                       title: "View all",
                    //                       fontSize: 12,
                    //                       color: blueColor,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             //Space
                    //             const SizedBox(height: 20,),
                    //             //
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Container(
                    //                     child: Column(
                    //                       children: [
                    //                         Row(
                    //                           children: [
                    //                             CustomText(
                    //                               title: "1",
                    //                               fontSize: 16,
                    //                               color: darkBlueColor,
                    //                             ),
                    //                             //Space
                    //                             const SizedBox(width: 10,),
                    //                             Container(
                    //                               width: 45,
                    //                               height: 45,
                    //                               decoration: const BoxDecoration(
                    //                                 shape: BoxShape.circle,
                    //                                 image: const DecorationImage(
                    //                                     fit: BoxFit.cover,
                    //                                     image: AssetImage("assets/images/profile_img.jpg")
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             //Space
                    //                             const SizedBox(width: 10,),
                    //                             Expanded(
                    //                               child: CustomText(
                    //                                 title: "Name one",
                    //                                 fontSize: 14,
                    //                                 color: darkBlueColor,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                         //Space
                    //                         const SizedBox(height: 8,),
                    //                         Row(
                    //                           children: [
                    //                             CustomText(
                    //                               title: "2",
                    //                               fontSize: 16,
                    //                               color: darkBlueColor,
                    //                             ),
                    //                             //Space
                    //                             const SizedBox(width: 10,),
                    //                             Container(
                    //                               width: 45,
                    //                               height: 45,
                    //                               decoration: const BoxDecoration(
                    //                                 shape: BoxShape.circle,
                    //                                 image: const DecorationImage(
                    //                                     fit: BoxFit.cover,
                    //                                     image: AssetImage("assets/images/profile_img.jpg")
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             //Space
                    //                             const SizedBox(width: 10,),
                    //                             Expanded(
                    //                               child: CustomText(
                    //                                 title: "Name two",
                    //                                 fontSize: 14,
                    //                                 color: darkBlueColor,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                         //Space
                    //                         const SizedBox(height: 8,),
                    //                         Row(
                    //                           children: [
                    //                             CustomText(
                    //                               title: "3",
                    //                               fontSize: 16,
                    //                               color: darkBlueColor,
                    //                             ),
                    //                             //Space
                    //                             const SizedBox(width: 10,),
                    //                             Container(
                    //                               width: 45,
                    //                               height: 45,
                    //                               decoration: const BoxDecoration(
                    //                                 shape: BoxShape.circle,
                    //                                 image: DecorationImage(
                    //                                     fit: BoxFit.cover,
                    //                                     image: const AssetImage("assets/images/profile_img.jpg")
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             //Space
                    //                             const SizedBox(width: 10,),
                    //                             Expanded(
                    //                               child: CustomText(
                    //                                 title: "Name three",
                    //                                 fontSize: 14,
                    //                                 color: darkBlueColor,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   width: 125,
                    //                   decoration: BoxDecoration(
                    //                       color: blueColor,
                    //                       borderRadius: BorderRadius.circular(12)
                    //                   ),
                    //                   padding: const EdgeInsets.symmetric(vertical: 12),
                    //                   child: Column(
                    //                     children: [
                    //                       //My Rank
                    //                       Container(
                    //                         alignment: Alignment.center,
                    //                         child: CustomText(
                    //                           title: "My Rank",
                    //                           fontSize: 14,
                    //                           color: whiteColor,
                    //                         ),
                    //                       ),
                    //                       //Space
                    //                       const SizedBox(height: 5,),
                    //                       //img
                    //                       Row(
                    //                         mainAxisAlignment: MainAxisAlignment.center,
                    //                         children: [
                    //                           Container(
                    //                             width: 60,
                    //                             height: 60,
                    //                             decoration: BoxDecoration(
                    //                               shape: BoxShape.circle,
                    //                               border: Border.all(
                    //                                   width: 1,
                    //                                   color: blueColor
                    //                               ),
                    //                               image: const DecorationImage(
                    //                                   fit: BoxFit.cover,
                    //                                   image: const AssetImage("assets/images/profile_img.jpg")
                    //                               ),
                    //                             ),
                    //                             child: Stack(
                    //                               clipBehavior: Clip.none,
                    //                               children: [
                    //                                 Positioned.directional(
                    //                                     textDirection: Directionality.of(context),
                    //                                     end: -5,
                    //                                     bottom: -2,
                    //                                     child: Container(
                    //                                       padding: const EdgeInsets.all(5),
                    //                                       decoration: const BoxDecoration(
                    //                                           shape: BoxShape.circle,
                    //                                           color: blueColor2
                    //                                       ),
                    //                                       child: Center(
                    //                                         child: CustomText(
                    //                                           title: "24",
                    //                                           fontSize: 10,
                    //                                           color: whiteColor,
                    //                                         ),
                    //                                       ),
                    //                                     ))
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       //Space
                    //                       const SizedBox(height: 5,),
                    //                       //User Name
                    //                       Container(
                    //                         alignment: Alignment.center,
                    //                         child: CustomText(
                    //                           title: "User Name",
                    //                           fontSize: 14,
                    //                           color: whiteColor,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //Space
                    const SizedBox(height: 20,),
                    //card
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Card(
                    //     elevation: 3,
                    //     shape:  RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12)
                    //     ),
                    //     child: Container(
                    //       width: double.infinity,
                    //       height: 283,
                    //       padding: const EdgeInsets.only(right: 12,top: 16,bottom: 16),
                    //       child: Row(
                    //         children: [
                    //           Expanded(
                    //             flex: 2,
                    //             child: Container(
                    //               padding: const EdgeInsets.only(right: 12),
                    //               child: Column(
                    //                 children: [
                    //                   Container(
                    //                     padding: const EdgeInsets.only(left: 12),
                    //                     alignment: Alignment.centerLeft,
                    //                     child: CustomText(
                    //                       title: "My Skill Level",
                    //                       fontSize: 18,
                    //                       fontWeight: FontWeight.w700,
                    //                       color: darkBlueColor,
                    //                     ),
                    //                   ),
                    //                   //Space
                    //                   const SizedBox(height: 30,),
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
                    //                           barRadius: const Radius.circular(8),
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
                    //                   const SizedBox(height: 30,),
                    //                   //
                    //                   Container(
                    //                     padding: const EdgeInsets.only(left: 12),
                    //                     child: Row(
                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                    //                       children: [
                    //                         Image.asset("assets/icons/ic_traced.png",color: blueColor,),
                    //                         //Space
                    //                         const SizedBox(width: 8,),
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
                    //                               const SizedBox(height: 8,),
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
                    //             flex: 3,
                    //             child: Container(
                    //               height: double.infinity,
                    //               decoration: BoxDecoration(
                    //                   color: lightblueColor,
                    //                   borderRadius: BorderRadius.circular(12)
                    //               ),
                    //               padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
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
                    //                   const SizedBox(height: 5,),
                    //                 ConstrainedBox(
                    //                     constraints: BoxConstraints.expand(height: 200.0),
                    //                       child: const CustomChart()),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //Space
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
