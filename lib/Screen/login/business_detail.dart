import 'package:flutter/material.dart';

import '../../HttpService/HttpService.dart';
import '../../HttpService/model/Terms_Use_Model.dart';
import '../../utill/color_resources.dart';
import '../../utill/styles.dart';

class business_detail extends StatefulWidget {
  int i;
  String text;

  business_detail(this.i, this.text);

  @override
  State<business_detail> createState() => _business_detailState();
}

class _business_detailState extends State<business_detail> {
  List<Data> business_detail_list = List.empty(growable: true);
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    api_call();
  }

  api_call() {
    widget.i == 0
        ? HttpService.terme_use_api().then(
            (value) {
              if (mounted) {
                setState(
                  () {
                    business_detail_list = List.empty(growable: true);
                    var business_detail = TermsUseModel.fromJson(value).data;
                    business_detail_list.add(business_detail);
                    print("values::::::::::::::${{business_detail_list}}");
                    loading = false;
                  },
                );
              }
            },
          )
        : HttpService.privacy_policy_api().then(
            (value) {
              if (mounted) {
                setState(
                  () {
                    business_detail_list = List.empty(growable: true);
                    var business_detail = TermsUseModel.fromJson(value).data;
                    business_detail_list.add(business_detail);
                    print("values::::::::::::::${{business_detail_list}}");
                    loading = false;
                  },
                );
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorResources.ORANGE_WHITE,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "${widget.text}",
          style: poppinsMedium.copyWith(
              color: ColorResources.BLACK, fontSize: width * 0.040),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorResources.BLACK,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height - 100,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      child: Text(
                        business_detail_list[0].value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
