import 'package:flutter/material.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';
class Proof_Verification extends StatefulWidget {
  String langType;
  Proof_Verification(this.langType);

  @override
  State<Proof_Verification> createState() => _Proof_VerificationState();
}

class _Proof_VerificationState extends State<Proof_Verification> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final st = MediaQuery.of(context).padding.top;
    final tbody = height - st;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
          title: widget.langType=="English"?Text('Proof Verification & Bio',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('सबूत सत्यापन और जैव',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)),
          backgroundColor: ColorResources.ORANGE_WHITE,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: ListView(
          children: [

          ],
        ),
      ),
    );
  }
}
