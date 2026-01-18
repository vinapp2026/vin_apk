import 'dart:async';
import 'package:VIN/models/custom_model.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class CustomSlider extends StatefulWidget {
   CustomSlider({
     Key? key}) : super(key: key);


  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int currentPage=0;
  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 5), (Timer timer) {
    //   // if (currentPage < 4) {
    //   //   currentPage++;
    //   // } else {
    //   //   currentPage = 0;
    //   // }
    //   buttonCarouselController.animateToPage(
    //     currentPage,
    //     duration: Duration(milliseconds: 350),
    //     curve: Curves.ease,
    //   );
    // });
  }
  AnimatedContainer buildDot(int index){
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.only(right: 4),
      width: currentPage==index? 20:6,
      height: 6,
      decoration: BoxDecoration(
          color: currentPage==index? whiteColor:lightblueColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(3)
      ),
    );
  }
  CarouselController buttonCarouselController = CarouselController();

  Widget slider(){
    return  Column(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentPage = index;
                });
              },
              height: 150,
              aspectRatio: 16/10,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: sliderData.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(i.img!)
                        )
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        // ignore: deprecated_member_use
        //dote
        Container(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(sliderData.length, (index)=> buildDot(index)),
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: slider(),
    );
  }
}
