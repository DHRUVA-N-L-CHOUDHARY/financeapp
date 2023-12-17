import 'package:financeapp/app_view.dart';
import 'package:financeapp/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRespository;
  const MyApp(this.userRespository, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRespository),
      child: const MyAppView(),
    );
  }
}
