import 'package:ewallet_app/cubit/register/register_cubit.dart';
import 'package:ewallet_app/models/request_registrasi.dart';
import 'package:ewallet_app/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../shared/shared_methods.dart';
import '../shared/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validate() {
    if (firstnameController.text.isEmpty ||
        lastnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            LoadingWidget(context).loading(true);
          }
          if (state is RegisterLoaded) {
            LoadingWidget(context).loading(false);
            Alert(
              context: context,
              type: AlertType.success,
              title: "Success",
              desc: state.responseRegistration.message,
              buttons: [
                DialogButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  width: 120,
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ).show();
          }
        },
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 70,
                horizontal: 70,
              ),
              child: Image.asset(
                'assets/images/nutech-logo.png',
                height: 50,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Join Us to Unlock \nYour Growth',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: 327,
              height: 450,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 16),
                    child: TextFormField(
                      controller: firstnameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          label: Text(
                            'First Name',
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          hintText: 'Input your First Name',
                          hintStyle: const TextStyle(color: softGreyColor)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 16),
                    child: TextFormField(
                      controller: lastnameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          label: Text(
                            'Last Name',
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          hintText: 'Input your Lastname',
                          hintStyle: const TextStyle(color: softGreyColor)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 16),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 16),
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
                          context.read<RegisterCubit>().register(
                              RequestRegistrasi(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  firstName: firstnameController.text,
                                  lastName: lastnameController.text));
                        } else {
                          showCustomSnackBar(
                              context, 'Semua field harus diisi');
                        }
                      },
                      child: Text(
                        'Register',
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: Text(
                'Sign In',
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
