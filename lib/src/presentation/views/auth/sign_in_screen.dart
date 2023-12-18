import 'package:financeapp/src/presentation/views/auth/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:financeapp/src/presentation/widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
	final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	bool signInRequired = false;
	IconData iconPassword = Icons.remove_rounded;
	bool obscurePassword = true;
	String? _errorMsg;
	
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
			listener: (context, state) {
				if(state is SignInSuccess) {
					setState(() {
					  signInRequired = false;
					});
					Navigator.popAndPushNamed(context,'/landing');
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsg = 'Invalid email or password';
					});
				}
			},
			child: Form(
					key: _formKey,
					child: Column(
						children: [
							 SizedBox(height: 20.h),
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.9,
								child: MyTextField(
									controller: emailController,
									hintText: 'Email',
									obscureText: false,
									keyboardType: TextInputType.emailAddress,
									prefixIcon: const Icon(Icons.email),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field';
										} else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
											return 'Please enter a valid email';
										}
										return null;
									}
								)
							),
							 SizedBox(height: 10.h),
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.9,
								child: MyTextField(
									controller: passwordController,
									hintText: 'Password',
									obscureText: obscurePassword,
									keyboardType: TextInputType.visiblePassword,
									prefixIcon: const Icon(Icons.lock),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field';
										} else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
											return 'Please enter a valid password';
										}
										return null;
									},
									suffixIcon: IconButton(
										onPressed: () {
											setState(() {
												obscurePassword = !obscurePassword;
												if(obscurePassword) {
													iconPassword = Icons.remove_red_eye;
												} else {
													iconPassword = Icons.remove_rounded;
												}
											});
										},
										icon: Icon(iconPassword),
									),
								),
							),
							 SizedBox(height: 20.h),
							!signInRequired
								? SizedBox(
										width: MediaQuery.of(context).size.width * 0.5,
										child: TextButton(
											onPressed: () {
												if (_formKey.currentState!.validate()) {
													context.read<SignInBloc>().add(SignInRequired(
														emailController.text,
														passwordController.text)
													);
												}
											},
											style: TextButton.styleFrom(
												elevation: 3.0,
												backgroundColor: Theme.of(context).colorScheme.primary,
												foregroundColor: Colors.white,
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(60)
												)
											),
											child:  Padding(
												padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
												child: Text(
													'Sign In',
													textAlign: TextAlign.center,
													style: TextStyle(
														color: Colors.white,
														fontSize: 16.sp,
														fontWeight: FontWeight.w600
													),
												),
											)
										),
									)
							: const CircularProgressIndicator(),
						],
					)
				),
		);
  }
}