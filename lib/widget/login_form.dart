import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/authentication/authentication.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/bloc/login/login.dart';
import 'package:npa_user/page/sign_up_page.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/util/util.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/loading_indicator.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  const LoginForm({Key key, @required this.userRepository}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle style = TextStyle(fontSize: 18.0, color: Colors.black);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = true;

  String firebaseToken = "";

  @override
  void initState() {
    super.initState();
    getFirebaseToken();
  }

  getFirebaseToken() async {
    await _firebaseMessaging.getToken().then((_key) {
      print(_key);
      firebaseToken = _key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              FlushbarHelper.createError(
                title: "Error",
                message: "Login failed, Please check Phone number or Password",
              )..show(context);
            }

            if (state is LoginSuccess) {
              final user = state.user;
              // if (user.statusId == 1) {
              //   Scaffold.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text("Complete Registration with Dealer"),
              //       backgroundColor: Colors.redAccent,
              //     ),
              //   );
              // } else if (user.statusId == 2) {
              FlushbarHelper.createSuccess(
                  title: "Success",
                  message: "Logged in",
                  duration: Duration(seconds: 2))
                ..show(context).then((result) {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .dispatch(LoggedIn(token: user.token));
                });
              // }
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                  context, homeRoute, (Route<dynamic> route) => false);
            }
          },
        ),
      ],
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildPhoneNumberField(),
              // SizedBox(
              //   height: 20,
              // ),
              _buildPasswordField(),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 5),
                  child: Text(
                    'Forgot Password ?',
                    // style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(00.0)),
                      side: BorderSide(color: Colors.white)),
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  // color: Theme.of(context).buttonColor,
                  textColor: Colors.white,
                  child: Text('Login', style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      FlushbarHelper.createInformation(
                          message: "Please enter values for required fields")
                        ..show(context);
                      return;
                    } else {
                      state is! LoginLoading ? _onLoginButtonPressed() : null;
                      if (state is LoginLoading) {
                        _showProgress();
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FlatButton(
                child: Text(
                  'Create an account, Register',
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      // replcet the curent layout unlike push that just creates new page
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext cotext) => RegisterPage(
                                userRepository: widget.userRepository,
                              )));
                },
              ),
              Container(
                child: state is LoginLoading ? LoadingIndicator() : null,
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context)
      ..dispatch(
        LoginButtonPressed(
          phoneNumber: _phoneNumberController.text.trim(),
          password: _passwordController.text.trim(),
          firebaseToken: firebaseToken,
        ),
      );
  }

  _showProgress() {
    FlushbarHelper.createLoading(
        message: "Signin in",
        linearProgressIndicator: LinearProgressIndicator());
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      // autovalidate: true,
      validator: (String value) {
        if (value.trim().length < 10 || value.trim().isEmpty)
          return 'Please enter a valid Phone Number.';
        return null;
      },

      style: style,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      decoration: inputDecoration('Phone Number'),
      controller: _phoneNumberController,
    );
  }

  _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: _showPassword,
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Password.';

        return null;
      },
      style: style,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: colorPrimary),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleVisibility,
          )),
      controller: _passwordController,
    );
  }
}
