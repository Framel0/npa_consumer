import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/authentication/authentication.dart';
import 'package:npa_user/bloc/bloc.dart';
import 'package:npa_user/bloc/login/login.dart';
import 'package:npa_user/page/sign_up_page.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/util/util.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  const LoginForm({Key key, @required this.userRepository}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _loginData = {'email': null, 'password': null};

  TextStyle style = TextStyle(fontSize: 18.0, color: Colors.black);

  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
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
                      return;
                    } else {
                      state is! LoginLoading ? _onLoginButtonPressed() : null;
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
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
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
        ),
      );
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

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Password.';

        return null;
      },
      style: style,
      keyboardType: TextInputType.text,
      decoration: inputDecoration('Password'),
      controller: _passwordController,
    );
  }
}
