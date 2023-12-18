import 'package:financeapp/src/presentation/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:financeapp/src/presentation/views/auth/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:financeapp/src/presentation/views/auth/welcome_screen.dart';
import 'package:financeapp/src/presentation/views/landing/landing_page_bloc/landing_page_bloc.dart';
import 'package:financeapp/src/presentation/views/landing/landing_screen.dart';
import 'package:financeapp/src/presentation/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
        });
      case '/welcome':
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => AuthenticationBloc(
                      userRepository: arguments["userRepository"]),
                  child: WelcomeScreen(),
                ));
      case '/landing':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => LandingPageBloc(),
                    ),
                    BlocProvider(
                      create: (context) => MyUserBloc(
                          myUserRepository:
                              context.read<AuthenticationBloc>().userRepository)
                        ..add(
                          GetMyUser(
                            myUserId: context
                                .read<AuthenticationBloc>()
                                .state
                                .user!
                                .uid,
                          ),
                        ),
                    ),
                  ],
                  child: LandingPage(),
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: Center(child: Text("Error")),
      );
    });
  }
}
