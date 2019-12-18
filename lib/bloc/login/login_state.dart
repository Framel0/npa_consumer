import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:npa_user/model/models.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class InitialLoginState extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({@required this.user});
  @override
  String toString() => 'LoginSuccess';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);
  @override
  String toString() => 'LoginFailure { error: $error }';
}
