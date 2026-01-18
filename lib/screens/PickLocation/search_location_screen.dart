import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:VIN/widgets/satatefull_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
class SearchLocationScreen extends StatefulWidget {
   SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final searchLocationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: true);

    return ModalProgressHUD(
      inAsyncCall: Provider.of<MainProvider>(context, listen: true).isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Image.asset("assets/icons/ic_back.png",color: darkBlueColor,),
          ),
          title: CustomTextField(
            controller: searchLocationController,
            keyboardType: TextInputType.text,
            textFieldFillColor: whiteColor,
            onChanged: (val) {},
            hintText: "Search",
            suffixIcon: CustomInkWell(
              onTap: (){
                searchLocationController.clear();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.clear,color: blackColor,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
