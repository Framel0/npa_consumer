import 'package:equatable/equatable.dart';

abstract class IssueState extends Equatable {
  IssueState();
}

class InitialIssueState extends IssueState {
  @override
  List<Object> get props => [];
}
