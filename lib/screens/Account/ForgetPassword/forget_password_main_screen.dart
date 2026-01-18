import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/satatefull_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forget_email_password.dart';
import 'forget_phone_password.dart';
class ForgetPasswordMainScreen extends StatefulWidget {
   ForgetPasswordMainScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordMainScreen> createState() => _ForgetPasswordMainScreenState();
}

class _ForgetPasswordMainScreenState extends State<ForgetPasswordMainScreen>with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // final MainProvider mainProvider =
    // Provider.of<MainProvider>(context, listen: false);

    return StatefulWrapper(
        onInit: (){
          Provider.of<MainProvider>(context, listen: false).signInTabFung(this);
        },
        child: Consumer<MainProvider>(
            builder: (context,mainProvider,child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: whiteColor,
                elevation: 0,
                leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: blackColor,)
                ),
              ),
              body: Column(
                children: [
                  //Space
                  const SizedBox(height: 10,),
                  //ic_lock
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mediumBlueColor2
                    ),
                    child: Center(
                      child: Image.asset("assets/icons/ic_lock.png",scale: 1.5,),
                    ),
                  ),
                  //Space
                  const SizedBox(height: 25,),
                  //Reset Your Password
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.center,
                    child: CustomText(
                      title: "Reset Your Password",
                      fontSize: 18,
                      color: blackColor,
                    ),
                  ),
                  //Space
                  const SizedBox(height: 15,),
                  //TabBar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
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
                  Flexible(
                    child: TabBarView(
                      physics: ClampingScrollPhysics(),
                      controller: mainProvider.signInTabController,
                      children: [
                        ForgetEmailPassword(),
                        ForgetPhonePassword(),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        ),
        dispose: (){}
    );
  }
}
