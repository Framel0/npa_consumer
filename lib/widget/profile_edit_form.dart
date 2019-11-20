import 'package:flutter/material.dart';
import 'package:npa_user/util/text_input_util.dart';

class ProfileEditForm extends StatefulWidget {
  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle formTextStyle = TextStyle(fontSize: 18.0, color: Colors.black);

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildFirstNameField(),
          SizedBox(
            height: 20,
          ),
          _buildLastNameField(),
          SizedBox(
            height: 20,
          ),
          _buildPhoneNumberField(),
          SizedBox(
            height: 20,
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
                'Save',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                _formKey.currentState.save();

                if (!_formKey.currentState.validate()) {
                  return;
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstNameField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter First Name.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("First Name"),
      controller: _firstNameController,
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Last Name.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Last Name"),
      controller: _lastNameController,
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().length < 10 || value.trim().isEmpty)
          return 'Please enter valid Phone Number.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      decoration: inputDecoration('Phone Number'),
      controller: _phoneNumberController,
    );
  }
}
