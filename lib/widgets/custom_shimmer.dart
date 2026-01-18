import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CustomShimmer extends StatelessWidget {
  const CustomShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shimmerList();
  }
  Widget shimmerList(){
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: GridView.count(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 15),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: List.generate(20, (index){
              return dummyListViewCell();
            }
            )));
  }

  Widget dummyListViewCell() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 8.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
              ),
              Container(
                width: double.infinity,
                height: 8.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
              ),
              Container(
                width: 40.0,
                height: 8.0,
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
