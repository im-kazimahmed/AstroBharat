import 'package:flutter/material.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';

class ConfirmDialogView extends StatefulWidget {
  const ConfirmDialogView(
      {Key? key,
      required this.description,
      required this.leftButtonText,
      required this.rightButtonText,
      required this.onAgreeTap})
      : super(key: key);

  final String description, leftButtonText, rightButtonText;
  final Function onAgreeTap;

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ConfirmDialogView> {
  @override
  Widget build(BuildContext context) {
    return NewDialog(widget: widget);
  }
}

class NewDialog extends StatelessWidget {
  const NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ConfirmDialogView widget;

  @override
  Widget build(BuildContext context) {

    const Widget _largeSpacingWidget = SizedBox(
      height: 20.0,
    );

    final Widget _messageWidget = Text(widget.description, style: poppinsMedium,);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  color: ColorResources.ORANGE),
          child: Row(
            children: const <Widget>[
              Icon(
                Icons.help_outline,
                color: ColorResources.WHITE,
              ),
              Padding(padding: EdgeInsets.only(left: 5.0),
              child: Text(
                "Confirm",
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorResources.WHITE,fontWeight: FontWeight.bold),
              ),)
            ],
          ),
          ),
          _largeSpacingWidget,
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: _messageWidget,
          ),
          _largeSpacingWidget,
          Divider(
            color: ColorResources.GREY,
            height: 0.4,
          ),
          Row(children: <Widget>[
            Expanded(
                child: MaterialButton(height: 50, minWidth: double.infinity,
                  onPressed: () {
                  Navigator.of(context).pop();
                  },
                  child: Text(widget.leftButtonText,
                      style: poppinsMedium),
            )),
            Container(
                height: 50,
                width: 0.4,
                color: ColorResources.GREY),
            Expanded(
                child: MaterialButton(height: 50, minWidth: double.infinity,
                  onPressed: () {
                  widget.onAgreeTap();
                  },
                  child: Text(widget.rightButtonText, style: poppinsMedium.copyWith(color: Colors.black),),
            )),
          ])
        ],
      ),
    );
  }
}