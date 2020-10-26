import 'package:arshney/helper/Const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignDialog extends StatelessWidget {
  final String firstTitle, buttonRight;
  final IconData image;
  final Color color;

  SignDialog({
    this.firstTitle,
    this.buttonRight,
    this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  firstTitle,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 50.0),
                Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(buttonRight,
                        style: TextStyle(
                            fontSize: 18, color: Colors.indigoAccent)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            top: 20,
            child: CircleAvatar(
              backgroundColor: color,
              child: Icon(
                image,
                size: 50,
              ),
              radius: 50,
            ),
          ),
        ],
      ),
    );
  }
}
