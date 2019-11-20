import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class FetchAll extends RegisterEvent {
  @override
  String toString() {
    return "FetchAll";
  }
}

class RegisterButtonPressed extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;
  final String consumerId;
  final String residentialAddress;
  final double latitude;
  final double longitude;
  final int dealerId;

  RegisterButtonPressed({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.password,
    this.consumerId,
    this.residentialAddress,
    this.latitude,
    this.longitude,
    this.dealerId,
  }) : super([
          firstName,
          lastName,
          phoneNumber,
          password,
          consumerId,
          residentialAddress,
          latitude,
          longitude,
          dealerId,
        ]);

  // RegisterButtonPressed(
  //     {this.fullName, this.email, this.phoneNumber, this.password})
  //     : super([fullName, email, phoneNumber, password]);

  @override
  String toString() {
    return """Register Button Pressed 
    """;
  }
}
