import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';

class CustomTextTitle extends StatelessWidget {
  final String title;

  CustomTextTitle(
      {required this.title});

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 2),
      margin: EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title,
              textAlign: TextAlign.start,
              style: poppinsMedium.copyWith(color:ColorResources.BLACK, fontSize: 15)),
        ],
      ),
    );
  }
}

class CustomTextTitle_Icon extends StatelessWidget {
  final IconData icon;
  final String title;

  CustomTextTitle_Icon(
      {required this.icon,required this.title});

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 2),
      margin: EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(icon,size: AppConstants.itemWidth*0.05,color: ColorResources.COLOR_PRIMERY,),
          SizedBox(width: AppConstants.itemWidth*0.02,),
          Text(title,
              textAlign: TextAlign.start,
              style: poppinsMedium.copyWith(color:ColorResources.BLACK, fontSize: 15)),
        ],
      ),
    );
  }
}

class HelpTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;

  HelpTextField(
      {this.controller,
        this.hintText,
        this.textInputType,
        this.maxLine,
        this.focusNode,
        this.nextNode,
        this.textInputAction,
        this.isPhoneNumber = false,
        this.isValidator=false,
        this.validatorMessage,
        this.capitalization = TextCapitalization.none,
        this.fillColor});

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorResources.EVENT_BG,
          borderRadius:BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(0.25),
              blurRadius: 0.1,
            )
          ]
      ),
      margin: EdgeInsets.only(bottom: 9,left: 3,right: 3),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine ?? 1,
        textCapitalization: capitalization,
        textAlign: TextAlign.left,
        maxLength: isPhoneNumber ? 10:null,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        initialValue: null,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        style: poppinsMedium.copyWith(color: ColorResources.BLACK),
        inputFormatters: [isPhoneNumber ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter],
        decoration: InputDecoration(
          hintText: hintText ?? '',
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          counterText: '',
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          hintStyle: poppinsMedium.copyWith(color: Theme.of(context).hintColor),
          errorStyle: TextStyle(height: 1.5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class WhiteTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;

  WhiteTextField(
      {this.controller,
        this.hintText,
        this.textInputType,
        this.maxLine,
        this.focusNode,
        this.nextNode,
        this.textInputAction,
        this.isPhoneNumber = false,
        this.isValidator=false,
        this.validatorMessage,
        this.capitalization = TextCapitalization.none,
        this.fillColor});

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius:BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: ColorResources.BLACK.withOpacity(0.25),
              blurRadius: 5
            )
          ]
      ),
      margin: EdgeInsets.only(bottom: 9,left: 3,right: 3),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine ?? 1,
        textCapitalization: capitalization,
        textAlign: TextAlign.left,
        maxLength: isPhoneNumber ? 10:null,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        initialValue: null,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        style: poppinsMedium.copyWith(color: ColorResources.BLACK),
        inputFormatters: [isPhoneNumber ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter],
        decoration: InputDecoration(
          hintText: hintText ?? '',
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          counterText: '',
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          hintStyle: poppinsMedium.copyWith(color: Theme.of(context).hintColor),
          errorStyle: TextStyle(height: 1.5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}