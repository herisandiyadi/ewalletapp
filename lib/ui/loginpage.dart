import 'package:ewallet_app/cubit/login/login_cubit.dart';
import 'package:ewallet_app/models/login_request.dart';
import 'package:ewallet_app/shared/loading_widget.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/shared_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            LoadingWidget(context).loading(true);
          } else if (state is LoginLoaded) {
            LoadingWidget(context).loading(true);
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        },
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 110,
              ),
              child: Image.asset(
                'assets/images/nutech-logo.png',
                height: 50,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Sign In & \nGrow Your Finance',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: 327,
              height: 317,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          label: Text(
                            'Email Address',
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          hintText: 'Input your email address',
                          hintStyle: const TextStyle(color: softGreyColor)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          label: Text(
                            'Password',
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          hintText: 'Input your password',
                          isDense: true,
                          hintStyle: const TextStyle(color: softGreyColor)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Forgot Password',
                          style: blueTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56),
                        color: orangeCOlor),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (validate()) {
                          context.read<LoginCubit>().login(
                                LoginRequest(
                                    email: emailController.text,
                                    password: passwordController.text),
                              );
                        } else {
                          showCustomSnackBar(
                              context, 'Semua field harus diisi');
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/register', (route) => false);
              },
              child: Text(
                'Create New Account',
                style:
                    greyTextStyle.copyWith(fontSize: 16, fontWeight: regular),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
