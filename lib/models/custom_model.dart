import 'dart:ui';

import 'package:VIN/utilites/constants.dart';

class CustomModel{
  String? title;
  String? subTitle;
  String? months;
  int? streak;
  String? img;
  Color? bgColor;
  Color? textColor;
  double? latitude;
  double? longitude;
  CustomModel({
    this.title,
    this.subTitle,
    this.months,
    this.streak,
    this.img,
    this.bgColor,
    this.textColor,
    this.latitude,
    this.longitude,
  });
}
List<CustomModel> sliderData =[
   CustomModel(img: "assets/images/b_court_img3.jpeg"),
   CustomModel(img: "assets/images/b_court_img1.jpeg"),
  // CustomModel(img: "assets/images/slider_img.png"),
  // CustomModel(img: "assets/images/slider_img.png"),
  // CustomModel(img: "assets/images/slider_img.png"),
  // CustomModel(img: "assets/images/slider_img.png"),
  // CustomModel(img: "assets/images/slider_img.png"),
];

//Court Profile
List<CustomModel> courtProfileScreenList =[
  CustomModel(img: "assets/icons/ic_parking.png",title: "Parking"),
  CustomModel(img: "assets/icons/ic_food.png",title: "Food"),
  CustomModel(img: "assets/icons/ic_changing_room.png",title: "Changing rooms"),
  CustomModel(img: "assets/icons/ic_waiting.png",title: "Wating area"),
];

//onTimeBookingScreen
List<CustomModel> onTimeBookingScreenList =[
  CustomModel(title: "14:00",bgColor: blueColor,textColor: whiteColor),
  CustomModel(title: "14:30",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "15:00",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "15:30",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "16:00",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "16:30",bgColor: lightblueColor,textColor: blueColor),
];

//BulkScreen
List<CustomModel> bulkScreenList =[
  CustomModel(title: "15 Days",bgColor: blueColor,textColor: whiteColor),
  CustomModel(title: "30 Days",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "45 Days",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "3 Months",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "6 Months",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "1 Year",bgColor: lightblueColor,textColor: blueColor),
];

//BulkScreen
List<CustomModel> bulkScreenTimeSlotList =[
  CustomModel(title: "Morning",subTitle: "9am - 11am",bgColor: blueColor,textColor: whiteColor),
  CustomModel(title: "Day",subTitle: "11am-4pm",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "Evening",subTitle: "4pm-7pm",bgColor: lightblueColor,textColor: blueColor),
  CustomModel(title: "Night",subTitle: "7pm-9pm",bgColor: lightblueColor,textColor: blueColor),
];

List<CustomModel> profileScreenGraphList =[
  CustomModel(months: "Jan",streak: 42,),
  CustomModel(months: "Fab",streak: 22,),
  CustomModel(months: "Mar",streak: 41,),
  CustomModel(months: "Apr",streak: 8,),
  CustomModel(months: "May",streak: 20,),
  CustomModel(months: "Jun",streak: 10,),
];