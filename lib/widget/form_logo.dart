import 'package:flutter/material.dart';
import 'package:npa_user/values/color.dart';

class FormLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/npa_logo.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          child: Text('Consumer',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: colorPrimary)),
        ),
      ],
    );
  }
}
