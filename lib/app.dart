import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_flow_flutter/authentication/bloc/authentication_bloc.dart';
import 'package:login_flow_flutter/home/view/home_page.dart';
import 'package:login_flow_flutter/login/view/login_page.dart';
import 'package:login_flow_flutter/splash/view/splash_view.dart';
import 'package:login_flow_flutter/src/authentication_repository.dart';
import 'package:login_flow_flutter/src/user_repository.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.unknown:
                // TODO: Handle this case.
                break;
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(
                  HomePage.route(),
                  (route) => false,
                );
                // TODO: Handle this case.
                break;
              case AuthenticationStatus.unauthenticated:
                // TODO: Handle this case.
                _navigator.pushAndRemoveUntil(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
