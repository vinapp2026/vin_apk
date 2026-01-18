import 'package:flutter/material.dart';
class CustomImage extends StatelessWidget {
   CustomImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/icons/preview.png",fit: BoxFit.cover,);
  }
}
