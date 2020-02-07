import 'package:flutter/material.dart';
import 'package:npa_user/values/color.dart';

InputDecoration inputDecoration(String label, {String hint}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
    hasFloatingPlaceholder: true,
    // focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: colorAccentYellow, width: 2),
    //     borderRadius: BorderRadius.all(Radius.circular(2))),
    // enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: colorAccentYellow, width: 2),
    //     borderRadius: BorderRadius.all(Radius.circular(2))),
    // disabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: colorAccentYellow, width: 2),
    //     borderRadius: BorderRadius.all(Radius.circular(2))),
    // errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: colorAccentYellow, width: 2),
    //     borderRadius: BorderRadius.all(Radius.circular(2))),
    // focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: colorAccentYellow, width: 2),
    //     borderRadius: BorderRadius.all(Radius.circular(2))),
    // hintText: 'Enter your product title',
    labelStyle: TextStyle(color: colorPrimary),
    errorStyle: TextStyle(
      color: Colors.red,
    ),
    labelText: label,
    hintText: hint,
  );
}

InputDecoration textDecoration(String label, {String hint}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    hasFloatingPlaceholder: true,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(0))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(0))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(0))),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(0))),
    // hintText: 'Enter your product title',
    labelStyle: TextStyle(color: Colors.white),
    errorStyle: TextStyle(
      color: Colors.white,
    ),
    labelText: label,
    hintText: hint,
  );
}

bool isEmail(String em) {
  String partten = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";

  RegExp regExp = new RegExp(partten);

  return regExp.hasMatch(em);
}
