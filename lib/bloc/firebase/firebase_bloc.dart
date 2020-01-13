import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/repositories.dart';
import './firebase.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final FirebaseRepository firebaseRepository;

  FirebaseBloc({@required this.firebaseRepository})
      : assert(firebaseRepository != null);
  @override
  FirebaseState get initialState => FirebaseInitial();

  @override
  Stream<FirebaseState> mapEventToState(
    FirebaseEvent event,
  ) async* {
    if (event is SendNotification) {
      yield FirebaseLoading();

      try {
        await firebaseRepository.sendNotification(
            title: event.title, body: event.body, token: event.token);

        yield FirebaseSent();
      } catch (e) {
        yield FirebaseError(error: e.toString());
      }
    }
  }
}
