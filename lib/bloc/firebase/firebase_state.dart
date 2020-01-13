import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FirebaseState extends Equatable {
  FirebaseState();
}

class FirebaseInitial extends FirebaseState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "Firebase Initial";
  }
}

class FirebaseLoading extends FirebaseState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "Firebase Loading";
  }
}

class FirebaseSent extends FirebaseState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "Firebase Sent";
  }
}

class FirebaseError extends FirebaseState {
  final String error;

  FirebaseError({@required this.error});
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "Firebase Error";
  }
}
