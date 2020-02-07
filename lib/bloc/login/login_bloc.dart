import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/bloc/authentication/authentication.dart';
import 'package:npa_user/repositories/repositories.dart';
import './login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await userRepository.authenticate(
            phoneNumber: event.phoneNumber,
            password: event.password,
            firebaseToken: event.firebaseToken);

        // authenticationBloc.dispatch(LoggedIn(token: token));

        yield LoginSuccess(user: user);
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
