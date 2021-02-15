import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login_flow_flutter/login/models/models.dart';
import 'package:login_flow_flutter/src/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event: event, state: state);
    } else if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event: event, state: state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event: event, state: state);
    }
  }

  LoginState _mapUsernameChangedToState({
    LoginUsernameChanged event,
    LoginState state,
  }) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([username, state.password]),
    );
  }

  LoginState _mapPasswordChangedToState({
    LoginPasswordChanged event,
    LoginState state,
  }) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.password]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState({
    LoginSubmitted event,
    LoginState state,
  }) async* {
    if (state.status.isInvalid) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.logIn(
          password: state.password.value,
          username: state.username.value,
        );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
