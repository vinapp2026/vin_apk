import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/Services/search_stadium_services.dart';
import 'package:VIN/models/get_stadium_list_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/location_provider.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/homePage/stadium_info_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class SearchScreen extends StatefulWidget {
   SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   final searchController = TextEditingController();
   late GetStadiumListModel getStadiumListModel;
   initState(){
     super.initState();
     getStadiumListModel = GetStadiumListModel();
   }
   searchStadiumList({
     String? searchData
   }) async {
     String _result ="";
     Map data ={
       "search_data": searchData,
       "latitude": UserModel().latitude,
       "longitude": UserModel().longitude
     };
     var response;
     response = await http.post(ApiUrl.searchStadium,
         headers: {
           "Content-Type": "application/json",
           "Accept": "application/json",
           'Authorization': 'Bearer ${UserModel().token}'
         },
         body: json.encode(data));
     // print(response.body);
     final Map<String, dynamic> authResponseData = json.decode(response.body);
     bool success = authResponseData["success"];
     success = authResponseData["success"];
     if (response.statusCode == 200) {
       getStadiumListModel = await GetStadiumListModel.fromJson(jsonDecode(response.body)) ;
       // poiModel = await poiModelFromJson(response.body) ;
       print(getStadiumListModel.data![0].id);
     }
     return getStadiumListModel;
   }
   @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          leading:  CustomInkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/ic_back.png",color: darkBlueColor,),
            ),
          ),
          title: CustomText(
            title: "Search Stadium",
            fontSize: 18,
            color: darkBlueColor,
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(55.0), // here the desired height
              child:  Container(
                padding: const EdgeInsets.only(left: 18,right: 18,),
                child: CustomTextField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (val) {
                   setState(() {
                     searchStadiumList(searchData: searchController.text.toString());
                   });
                  },
                  hintText: "Search",
                  fieldborderRadius: 10,
                  textFieldFillColor: lightblueColor.withOpacity(0.5),
                  fieldborderColor: blueColor,
                  suffixIcon: CustomInkWell(
                    onTap: (){
                     setState(() {
                       searchStadiumList(searchData: searchController.text.toString());
                     });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/icons/ic_search.png",scale: 10,color: blueColor,),
                    ),
                  ),
                ),
              ),
          ),
        ),
        body:Builder(
          builder: (context) {
            if(searchController.text.isNotEmpty&&getStadiumListModel.data==null){
              return  Container(
                alignment: Alignment.center,
                child: CustomText(
                  title: "No Record Found",
                  color: kPrimaryColor,
                  fontSize: 22,
                ),
              );
            }else if(searchController.text.isNotEmpty&&getStadiumListModel.data!.length>0){
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 15),
                  itemCount: getStadiumListModel.data!.length,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Container(
                      padding: const EdgeInsets.only(
                          bottom: 10),
                      child: CustomInkWell(
                        onTap: (){
                          Helper.toScreen(context, StadiumInfoScreen(stadiumId: getStadiumListModel.data![index].id,));
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius
                                  .circular(12)
                          ),
                          child: Container(
                           // width: double.infinity,
                            height: 120,
                            padding: const EdgeInsets
                                .symmetric(horizontal: 10,
                                vertical: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(12),
                                  ),
                                  //clipBehavior: Clip.hardEdge,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(12),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: CustomCachedNetworkImage(url: getStadiumListModel.data![index].stadiumAvatar,)),
                                      Positioned
                                          .directional(
                                        textDirection: Directionality
                                            .of(context),
                                        start: -10,
                                        top: -11,
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 8,
                                              vertical: 6),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .only(
                                                  topLeft: Radius
                                                      .circular(
                                                      12),
                                                  bottomRight: Radius
                                                      .circular(
                                                      12)
                                              ),
                                              color: blueColor
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  "assets/icons/ic_star.png",scale: 19,),
                                              //Space
                                              SizedBox(
                                                width: 3,),
                                              CustomText(
                                                title: getStadiumListModel.data![index].rating.toString(),
                                                fontSize: 12,
                                                color: whiteColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets
                                        .only(left: 12,),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                title: getStadiumListModel.data![index].name,
                                                fontSize: 14,
                                                color: darkBlueColor,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      10),
                                                  color: lightblueColor
                                                      .withOpacity(
                                                      0.4)
                                              ),
                                              padding: const EdgeInsets
                                                  .all(6.0),
                                              child: CustomText(
                                                title: "${getStadiumListModel.data![index].distance}"
                                                    " ${getStadiumListModel.data![index].disMeasurement}",
                                                fontSize: 9,
                                                color: blueColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //Space
                                        SizedBox(
                                          height: 5,),
                                        CustomText(
                                          title: "${getStadiumListModel.data![index].address}",
                                          fontSize: 12,
                                          color: greyColor,
                                          maxLines: 1,
                                        ),
                                        //Space
                                        SizedBox(
                                          height: 5,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                title: "Available today",
                                                fontSize: 12,
                                                color: mediumGreenColor,
                                              ),
                                            ),
                                            Image.asset("assets/icons/ic_traced2.png",scale:9,color: darkBlueColor,)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }else{
              return  Container(
                alignment: Alignment.center,
                child: CustomText(
                  title: "No Record Found",
                  color: kPrimaryColor,
                  fontSize: 22,
                ),
              );
            }
          }
        )
      ),
    );
  }
}
