
import 'dart:ui';

import 'package:VIN/utilites/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.textInputAction,
    this.enabled,
    this.obscureText,
    this.focusNode,
    this.onChanged,
     this.validation,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.isFilled,
    this.isUnderlineInputBorder,
    this.isOutlineInputBorder,
    this.isOutlineInputBorderColor,
    this.maxLength,
    this.fontSize,
    this.inputFormatter,
    this.onTap,
    this.fillColor,
    this.fieldborderColor,
    this.textFieldFillColor,
    this.fieldborderRadius,
    this.maxLines,
    this.contentPaddingLeft,
    this.contentPaddingRight,
    this.contentPaddingTop,
    this.contentPaddingBottom,
    this.containerPadding,
    this.textColor,
    this.hintTextColor,
    this.hintFontSize,
    this.textFontSize,
    this.textAlign,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus,
    Key? key}) : super(key: key);
  bool ? enabled;
  bool ? obscureText;
  String? Function(String?)? validation;
  String? Function(String?)? onChanged;
  Function? onTap;
  FocusNode? focusNode;
  TextEditingController? controller;
  TextInputType? keyboardType;
  String ? hintText;
  bool? isFilled;
  bool? isUnderlineInputBorder;
  bool? isOutlineInputBorder;
  Color? isOutlineInputBorderColor;
  int? maxLength;
  int? maxLines;
  double? fontSize;
  int? inputFormatter;
  Color? fillColor;
  Color? textFieldFillColor;
  Color? fieldborderColor;
  Color? textColor;
  Color? hintTextColor;
  double? textFontSize;
  double? hintFontSize;
  double? fieldborderRadius;
  double? contentPaddingTop;
  double? contentPaddingBottom;
  double? contentPaddingLeft;
  double? contentPaddingRight;
  double? containerPadding;
  TextAlign? textAlign;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputAction? textInputAction;
  bool? autofocus;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: containerPadding??0),
      decoration: BoxDecoration(
          color:fillColor??Colors.transparent,
          border: Border.all(
              width: fieldborderColor!=null? 0:1,
              color: fieldborderColor??Colors.transparent
          ),
          borderRadius: BorderRadius.circular(fieldborderRadius??4)
      ),
      child: TextFormField(
        autofocus: autofocus??false,
        textInputAction: textInputAction,
        enabled: enabled,
        obscureText: obscureText??false,
        maxLength: maxLength,
        maxLines: maxLines??1,
        focusNode: focusNode,
        onTap: ()=>onTap,
        validator: validation,
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        textAlign: textAlign??TextAlign.left,
      //  textAlignVertical:textAlign != null? TextAlignVertical.bottom:TextAlignVertical.center,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.only(left: contentPaddingLeft??12,right:contentPaddingRight?? 12,
          top: contentPaddingTop??13,bottom: contentPaddingBottom??13),
          isDense: true,
          hintText: hintText,
          hintStyle:  TextStyle(
              fontSize: hintFontSize??15,
              color: hintTextColor??darkBlueColor
          ),
          helperStyle:  const TextStyle(
              color: Colors.transparent,
          ),
          errorStyle: const TextStyle(
              color: Colors.red
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: textFieldFillColor,
          border:isUnderlineInputBorder==false||isOutlineInputBorder==false?InputBorder.none:isOutlineInputBorder==false?
          UnderlineInputBorder():OutlineInputBorder(
              borderSide: BorderSide(
                  width: isOutlineInputBorderColor!=null? 0:1,
                  color: isOutlineInputBorderColor??Colors.transparent
              ),
              borderRadius: BorderRadius.circular(fieldborderRadius??4)
          ),
          enabledBorder:isUnderlineInputBorder==false||isOutlineInputBorder==false?InputBorder.none:isOutlineInputBorder==false?
          UnderlineInputBorder():OutlineInputBorder(
              borderSide: BorderSide(
                  width: isOutlineInputBorderColor!=null? 0:1,
                  color: isOutlineInputBorderColor??Colors.transparent
              ),
              borderRadius: BorderRadius.circular(fieldborderRadius??4)
          ),
          focusedBorder:isUnderlineInputBorder==false||isOutlineInputBorder==false?InputBorder.none:isOutlineInputBorder==false?
          UnderlineInputBorder():OutlineInputBorder(
              borderSide: BorderSide(
                  width: isOutlineInputBorderColor!=null? 0:1,
                  color: isOutlineInputBorderColor??Colors.transparent
              ),
            borderRadius: BorderRadius.circular(fieldborderRadius??4)
          ),
          errorBorder: isUnderlineInputBorder==false||isOutlineInputBorder==false?InputBorder.none:isOutlineInputBorder==false?
          UnderlineInputBorder():OutlineInputBorder(
            borderSide: BorderSide(
                width: isOutlineInputBorderColor!=null? 0:1,
                color: redColor
            ),
              borderRadius: BorderRadius.circular(fieldborderRadius??4)
          ),
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(inputFormatter)],
        style:  TextStyle(
          color: textColor??blackColor,
          fontSize: textFontSize??15,
        ),
      ),
    );
  }
}
