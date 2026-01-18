import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/satatefull_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'signup_email.dart';
import 'signup_phone.dart';
class SignUpMainScreem extends StatefulWidget {
  const SignUpMainScreem({Key? key}) : super(key: key);

  @override
  State<SignUpMainScreem> createState() => _SignUpMainScreemState();
}

class _SignUpMainScreemState extends State<SignUpMainScreem>with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // final MainProvider mainProvider =
    // Provider.of<MainProvider>(context, listen: true);

    return StatefulWrapper(
        onInit: (){
          Provider.of<MainProvider>(context,listen:false).signInTabFung(this);
       },
        child:Consumer<MainProvider>(
            builder: (context,mainProvider,child) {
            return Scaffold(
              body: Column(
                children: [
                  //Space
                  const SizedBox(height: 40,),
                  //Welcome,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      title: "Welcome,",
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: darkBlueColor,
                    ),
                  ),
                  //Space
                  const SizedBox(height: 6,),
                  //Sign up to get started!
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      title: "Sign up to get started!",
                      fontSize: 18,
                      color: darkBlueColor,
                    ),
                  ),
                  //Space
                  const SizedBox(height: 30,),
                  //TabBar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TabBar(
                        controller: mainProvider.signInTabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 2,
                        indicatorColor: kPrimaryColor,
                        tabs: [
                          Tab(
                            child: CustomText(
                              title: "EMAIL ADDRESS",
                              fontSize: 15,
                              color: blackColor,
                            ),
                          ),
                          Tab(
                            child: CustomText(
                              title: "PHONE NUMBER",
                              fontSize: 15,
                              color: blackColor,
                            ),
                          ),
                        ]
                    ),
                  ),
                  //
                  Expanded(
                      child: TabBarView(
                        controller: mainProvider.signInTabController,
                        children: [
                          SignUpEmail(),
                          SignUpPhone(),
                        ],
                      ))
                ],
              ),
            );
          }
        ),
        dispose: (){}
    );
  }
}
