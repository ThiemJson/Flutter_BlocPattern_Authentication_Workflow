import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../login.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text("Authentication Failure"),
            ));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (String username) {
            context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(username: username));
          },
          decoration: InputDecoration(
            labelText: "Username",
            hintText: "example@email.com",
            errorText: state.username.invalid ? "Invailid username" : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) {
            context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: password));
          },
          obscureText: true,
          decoration: InputDecoration(
              labelText: "Password",
              errorText: state.password.invalid ? "Invailid password" : null),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        Widget child;
        if (state.status.isSubmissionInProgress) {
          child = const CircularProgressIndicator();
        } else {
          child = RaisedButton(
            color: Theme.of(context).primaryColor,
            key: const Key('loginForm_continue_raisedButton'),
            child: const Text(
              "LOGIN",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: state.status.isValidated
                ? () {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                : null,
          );
        }
        return child;
      },
    );
  }
}
