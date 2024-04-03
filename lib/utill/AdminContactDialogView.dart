import 'package:astrobharat/utill/share_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminContactDialogView extends StatefulWidget {
  const AdminContactDialogView({Key? key, required this.description, required this.leftButtonText,}) : super(key: key);

  final String description, leftButtonText;

  @override
  _AdminContactState createState() => _AdminContactState();
}

class _AdminContactState extends State<AdminContactDialogView> {
  @override
  Widget build(BuildContext context) {
    return AdminContactDialog(widget: widget);
  }
}

class AdminContactDialog extends StatelessWidget {
  final AdminContactDialogView widget;
  const AdminContactDialog({Key? key, required this.widget,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Widget _largeSpacingWidget = SizedBox(height: 20.0,);
    final Widget _messageWidget = Text(widget.description, style: TextStyle(color: Colors.black,fontSize: 14),);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: 20),
                // Image.asset('assets/images/round_true.png',height: 50,width: 50),
                // SizedBox(height: 10),
                // Text("Register Successful", textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                // )
              ],
            ),
            _largeSpacingWidget,
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: _messageWidget,
            ),
            _largeSpacingWidget,
            Row(children: <Widget>[
              Expanded(
                  child: MaterialButton(height: 50, minWidth: double.infinity,
                    onPressed: () {
                      PreferenceUtils.init();
                      PreferenceUtils.clear();
                      SystemNavigator.pop();
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const DefaultTextStyle(
                        style: TextStyle(),
                        child: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )),
            ])
          ],
        ),
      ),
    );
  }
}