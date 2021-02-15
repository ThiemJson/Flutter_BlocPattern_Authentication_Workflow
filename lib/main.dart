import 'package:flutter/material.dart';
import 'package:login_flow_flutter/app.dart';
import 'package:login_flow_flutter/src/authentication_repository.dart';
import 'package:login_flow_flutter/user_repository.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
