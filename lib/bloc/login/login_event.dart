import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String phoneNumber;
  final String password;

  LoginButtonPressed({@required this.phoneNumber, @required this.password})
      : super([phoneNumber, password]);

  @override
  String toString() =>
      'LoginButtonPressed { phoneNumber: $phoneNumber, password: $password }';
}
