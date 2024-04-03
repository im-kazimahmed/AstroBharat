import 'package:flutter/material.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';
class Call_History extends StatefulWidget {
  String langType;
  Call_History(this.langType);

  @override
  State<Call_History> createState() => _Call_HistoryState();
}

class _Call_HistoryState extends State<Call_History> {
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
          title: widget.langType=="English"? Text('Call History',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('कॉल इतिहास',
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
