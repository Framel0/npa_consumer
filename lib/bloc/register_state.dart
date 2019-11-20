import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super(props);
}

class InitialRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  String toString() {
    return "Register Loading";
  }
}

class RegisterFailuer extends RegisterState {
  final String error;

  RegisterFailuer({@required this.error}) : super([error]);

  @override
  String toString() {
    return "Register Failure {error : $error}";
  }
}
