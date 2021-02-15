import 'package:equatable/equatable.dart';
import 'package:login_flow_flutter/authentication_repository.dart';
import 'package:login_flow_flutter/src/models/model.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  // unknown, user ==  empty
  const AuthenticationState.unknown() : this._();

  // authenticated, user
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  // unauthenticated, user == empty
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
