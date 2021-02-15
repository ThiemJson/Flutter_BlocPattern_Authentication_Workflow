import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_flow_flutter/authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          RaisedButton(
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Builder(
              builder: (context) {
                final userID = context
                    .select((AuthenticationBloc bloc) => bloc.state.user.id);
                return Text('UserID: $userID');
              },
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
