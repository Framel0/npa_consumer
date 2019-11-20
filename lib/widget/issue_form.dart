import 'package:flutter/material.dart';
import 'package:npa_user/page/home_page.dart';
import 'package:npa_user/util/text_input_util.dart';

class IssueForm extends StatefulWidget {
  @override
  _IssueFormState createState() => _IssueFormState();
}

class _IssueFormState extends State<IssueForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle style = TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildNameField(),
          SizedBox(
            height: 20,
          ),
          _buildPhoneNumberField(),
          SizedBox(
            height: 20,
          ),
          _buildMessageField(),
          SizedBox(
            height: 35,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  side: BorderSide(color: Colors.white)),
              padding: EdgeInsets.symmetric(vertical: 12.0),
              // color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                } else {
                  Navigator.pushReplacement(
                      // replcet the curent layout unlike push that just creates new page
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext cotext) => MyHomePage()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Name.';
        return null;
      },
      style: style,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Name"),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      style: style,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: inputDecoration('Email Address'),
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Phone Number.';
        return null;
      },
      style: style,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      decoration: inputDecoration('Phone Number'),
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      maxLines: null,
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter your password.';
        return null;
      },
      style: style,
      keyboardType: TextInputType.multiline,
      decoration: inputDecoration('Message'),
    );
  }
}
