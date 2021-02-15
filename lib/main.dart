import 'package:flutter/material.dart';
import 'package:login_flow_flutter/authentication_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    authentication();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: Text("Nguyen Cao Thiem"),
        ),
      ),
    );
  }
}

void authentication() {
  final authenticationRepository = AuthenticationRepository();
  authenticationRepository.status.listen(print);
}
