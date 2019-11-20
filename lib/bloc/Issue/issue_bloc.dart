import 'dart:async';
import 'package:bloc/bloc.dart';
import './issue.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  @override
  IssueState get initialState => InitialIssueState();

  @override
  Stream<IssueState> mapEventToState(
    IssueEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
