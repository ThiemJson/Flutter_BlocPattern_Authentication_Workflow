import 'package:equatable/equatable.dart';
import 'package:login_flow_flutter/src/authentication_repository.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;

  AuthenticationStatusChanged({this.status});

  @override
  List<Object> get props => [status];
}
