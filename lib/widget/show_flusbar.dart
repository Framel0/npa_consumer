import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ShowFlusbar extends StatelessWidget {
  final BuildContext mContext;
  final Color backgroundColor;
  final String message;

  const ShowFlusbar(
      {Key key,
      @required this.backgroundColor,
      @required this.message,
      @required this.mContext})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flushbar(
      padding: EdgeInsets.all(5),
      borderRadius: 8,
      backgroundColor: backgroundColor,
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      flushbarStyle: FlushbarStyle.FLOATING,
      message: message,
    )..show(mContext);
  }
}
