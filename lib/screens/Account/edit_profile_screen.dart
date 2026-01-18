import 'dart:convert';
import 'dart:io';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/animation/slideright_toleft.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/phone_numb_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'account_email_screen.dart';
class EditProfileScreen extends StatefulWidget {
   EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
   final userNameController = TextEditingController();

   final lastNameController = TextEditingController();

   final emailController = TextEditingController();

   final phoneNumbController = TextEditingController();
   final bioController = TextEditingController();

   final formKey = GlobalKey<FormState>();

   List<String> genderList =[
     "Male",
     "Female",
     "Other",
   ];
  var genderVal = UserModel().gender;

   File? _image;

   final picker = ImagePicker();

   Future getImage() async {
     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
     if (pickedFile != null) {
       File tempFile = File(pickedFile.path);
       setState(() {
         _image = File(pickedFile.path);
         //String base64Doc = base64Encode(_image!.path.codeUnits);
        // AuthServices.updateUserProfile(profilePhoto: _image);
       });
     }
   }
   /// Variables
   PickedFile? imageFile;
   /// Get from gallery
   final ImagePicker _picker = ImagePicker();
  // File? _image;
   Future<void> _openImagePicker() async {
     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
     if (pickedFile != null) {

       setState(() {
         _image = File(pickedFile.path);
       });
       await AuthServices.uploadImage(image: File(pickedFile.path));
     }
   }

   Future<dynamic> uploadFileAsFormData(
       File param) async {
     try {
       final dio = Dio();
       dio.options.headers = {
         "Content-Type": "application/json",
         "Accept": "application/json",
         'Authorization': 'Bearer ${UserModel().token}'
       };

       final file = await MultipartFile.fromFile(param.path,
           filename: param.path.split('/').last);

       // final formData = FormData.fromMap({'picked_file': file});
       var formData = FormData();
       formData.files.addAll([
         MapEntry("avatar", file),
       ]);
      // formData.fields.add(MapEntry("user_code", UserModel().uid.toString()));
       final response = await dio.post(
         "http://65.0.25.94/api/update-user-profile",
         data: formData,
       );
       print("status ${response.data["status"]}");
       if (response.data["status"]) {
         return response.data["data"];
       }
       return null;
     } catch (err) {
       print('uploading error: $err');
     }
   }




   bool isLoading=false;

    uploadProfileImage(File param) async {
     try {
   //    isLoading = true;
       var result = await uploadFileAsFormData(param);
       if (result ==true) {
         UserModel().img = result["avatar"];
         // this._registerUser.thumbnailAvatar = result["thumbnail"];
         // this._registerUser.userCode = result["usercode"];
       }
     } finally {
       isLoading = false;
     }
   }






   String? userImg;
   Widget displayImage() {
     if (imageFile == null) {
       return Container(
         height: 110,
         width: 110,
         decoration: const BoxDecoration(
           shape: BoxShape.circle,
         ),
         child: CustomCachedNetworkImage(url: UserModel().img.toString(),),
       );
     } else {
       return Container(
         height: 110,
         width: 110,
         decoration: const BoxDecoration(
           shape: BoxShape.circle,
         ),
         child: ClipRRect(
           borderRadius: BorderRadius.circular(75),
           child: Image.file(
             _image!,
             fit: BoxFit.cover,
           ),
         ),
       );
     }
   }

   updateUserInfo()async{
     Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
     var result = await AuthServices.updateUserInfo(
       name: userNameController.text.toString(),
       gender: genderVal,
       bio: bioController.text.toString(),
       mobileNumber: phoneNumbController.text
     );
     if (result == true){
       AuthServices.getUserInfo();
        Navigator.pop(context);
       Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
       Helper.showSnack(context, "Successfully");

     }else {
       Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
       Helper.showSnack(context, "Invalid User");
     }
   }
  @override
  Widget build(BuildContext context) {
    userNameController.text = UserModel().username??"";
    emailController.text= UserModel().email??"";
    phoneNumbController.text= UserModel().phoneNo??"";
    bioController.text= UserModel().bio??"";
    return CustomParentWidget(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<MainProvider>(context).isLoading,
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
                    const SizedBox(width: 12,),
                    //
                    Expanded(
                      child: CustomText(
                        title: "Edit Profile",
                        fontSize: 18,
                        color: darkBlueColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),  //
              //
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //b
                      Container(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                //Space
                                SizedBox(height: 55,),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  clipBehavior: Clip.none,
                                  child: Container(
                                    width: double.infinity,
                                    height: 180,
                                    decoration: BoxDecoration(
                                        color: blueColor,
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Column(
                                      children: [
                                        //Space
                                        const SizedBox(height: 120,),
                                        //First Name
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          child:CustomTextField(
                                            controller: userNameController,
                                            keyboardType: TextInputType.text,
                                            onChanged: (val) {},
                                            hintText: "First Name",
                                            hintTextColor: darkBlueColor,
                                            fieldborderRadius: 10,
                                            textFieldFillColor: lightblueColor,
                                            fieldborderColor: blueColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //img
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              start: 0,
                              end: 0,
                              top: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomInkWell(
                                    onTap: (){
                                      //_getFromGallery();
                                      _openImagePicker();
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 110,
                                          height: 110,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: CustomInkWell(
                                              onTap: (){
                                                //_getFromGallery();
                                                _openImagePicker();
                                              },
                                              child: displayImage()),
                                        ),
                                        //
                                        Container(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomText(
                                              title: "Change Profile picture",
                                              fontSize: 14,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
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
                      const SizedBox(height: 40,),
                      //Email
                      if(emailController.text.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child:GestureDetector(
                          onTap: ()async{
                          //  Helper.toScreen(context, AccountEmailScreen());
                          //   Navigator.push(context, SlideRightToLeft(page: AccountEmailScreen())).
                          //   then((value)async{
                          //     await  AuthServices.getUserInfo();
                          //     setState(() {
                          //
                          //     });
                          //   });
                          },
                          child: CustomTextField(
                           enabled: false,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {},
                            hintText: "Email",
                            hintTextColor: darkBlueColor,
                            fieldborderRadius: 10,
                            textFieldFillColor: lightblueColor,
                            fieldborderColor: blueColor,
                            // suffixIcon: const Icon(
                            //   Icons.edit_rounded,
                            //   color: blackColor,
                            //   size: 23,
                            // ),
                          ),
                        ),
                      ),
                      //Space
                      const SizedBox(height: 15,),
                      //Phone Number
                      if(phoneNumbController.text.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child:GestureDetector(
                          onTap: ()async{
                           // Helper.toScreen(context, PhoneNumbScreen());
                           //  Navigator.push(context, SlideRightToLeft(page: PhoneNumbScreen())).
                           //  then((value)async{
                           //  await  AuthServices.getUserInfo();
                           //    setState(() {
                           //
                           //    });
                           //  });
                          },
                          child: CustomTextField(
                            enabled: false,
                            controller: phoneNumbController,
                            keyboardType: TextInputType.number,
                            onChanged: (val) {},
                            hintText: "Phone Number",
                            hintTextColor: darkBlueColor,
                            fieldborderRadius: 10,
                            textFieldFillColor: lightblueColor,
                            fieldborderColor: blueColor,
                            // suffixIcon: const Icon(
                            //   Icons.edit_rounded,
                            //   color: blackColor,
                            //   size: 23,
                            // ),
                          ),
                        ),
                      ),
                      //Space
                      const SizedBox(height: 15,),
                      //Gender
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child:  Container(
                          height: 50,
                          padding:
                          EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              color: lightblueColor,
                              border: Border.all(
                                width: 1,
                                color: blueColor
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                              onChanged: (String? value) {
                                setState(() {
                                  //UserModel().gender="";
                                  genderVal = value.toString();
                                  print(genderVal);
                                });
                              },
                              isExpanded: true,
                              underline: SizedBox(),
                              icon: Icon(Icons.arrow_drop_down_sharp,color: darkBlueColor,),
                              dropdownColor: whiteColor,
                              hint: CustomText(
                                title: "Gender",
                                color: darkBlueColor,
                              ),
                              value: genderVal.toString(),
                              items: genderList
                                  .map((e) => DropdownMenuItem(
                                child: Text(e.toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: darkBlueColor
                                  ),), value: e.toString(),))
                                  .toList()),
                        )
                        ),
                      //Space
                      const SizedBox(height: 15,),
                      //Bio
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child:CustomTextField(
                          controller: bioController,
                          keyboardType: TextInputType.text,
                          onChanged: (val) {},
                          hintText: "Bio",
                          maxLines: 4,
                          hintTextColor: darkBlueColor,
                          fieldborderRadius: 10,
                          textFieldFillColor: lightblueColor,
                          fieldborderColor: blueColor,
                        ),
                      ),
                      //Space
                      const SizedBox(height: 15,),
                      //Space
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child:  Container(
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
            child: CustomButton(
              onPressed: () {
                 // Helper.toScreen(context, AccountEmailScreen());
                updateUserInfo();
              },
              btnHeight: 48,
              btnRadius: 8,
              title: "Save",
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
}
