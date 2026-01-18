import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/satatefull_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'signin_email.dart';
import 'signin_phone.dart';

class SignInMainScreen extends StatefulWidget {
  SignInMainScreen({Key? key}) : super(key: key);

  @override
  State<SignInMainScreen> createState() => _SignInMainScreenState();
}

class _SignInMainScreenState extends State<SignInMainScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<MainProvider>(context, listen: false).signInTabFung(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    // Provider.of<MainProvider>(context, listen: false).disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body: Column(
          children: [
            //Space
            const SizedBox(
              height: 40,
            ),
            //Let’s Sign you in.
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.centerLeft,
              child: CustomText(
                title: "Let’s Sign you in.",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: darkBlueColor,
              ),
            ),
            //Space
            const SizedBox(
              height: 6,
            ),
            //You’ve been missed!
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.centerLeft,
              child: CustomText(
                title: "You’ve been missed!",
                fontSize: 18,
                color: darkBlueColor,
              ),
            ),
            //Space
            const SizedBox(
              height: 30,
            ),
            //TabBar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TabBar(
                  controller: Provider.of<MainProvider>(context, listen: false)
                      .signInTabController,
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
                  ]),
            ),
            //
            Expanded(
                child: TabBarView(
              controller: Provider.of<MainProvider>(context, listen: false)
                  .signInTabController,
              children: [
                SignInEmail(),
                SigInPhone(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
