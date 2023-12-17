import 'dart:ui';

import 'package:financeapp/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.green.shade100,
          body: Stack(
            children: [
              Align(
								alignment: const AlignmentDirectional(20, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width,
									width: MediaQuery.of(context).size.width,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.tertiary
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(-2.7, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width / 1.3,
									width: MediaQuery.of(context).size.width / 1.3,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.secondary
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(2.7, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width / 1.3,
									width: MediaQuery.of(context).size.width / 1.3,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.primary
									),
								),
							),
							BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
								child: Container(),
							),
              Center(child: Text("Finance App",
              style: TextStyle(fontSize: 25, color: Color.fromRGBO(54, 137, 131, 1), fontWeight: FontWeight.bold),
              )),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            onTap: (){
              if(state.status == AuthenticationStatus.authenticated)
              {
                Navigator.pushReplacementNamed(context, "/landing");
              }
              else
              {
                Navigator.pushReplacementNamed(context, "/welcome", arguments: {
                  "userRepository" : context.read<AuthenticationBloc>().userRepository
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left:20.0, right: 20.0, bottom: 40.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                color: Color.fromRGBO(54, 137, 131, 1),
                borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Next" ,style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)))),
            )),
        );
      },
    );
  }
}
