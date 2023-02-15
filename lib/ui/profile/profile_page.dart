import 'package:ewallet_app/cubit/login/login_cubit.dart';
import 'package:ewallet_app/cubit/profile/profile_cubit.dart';
import 'package:ewallet_app/shared/loading_widget.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void getProfile() {
    context.read<ProfileCubit>().getProfile();
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoaded) {
              final data = state.profileResponse.data;
              return ListView(
                children: [
                  const Icon(
                    Icons.account_box,
                    size: 184,
                    color: greyColor,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Data Profil',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Nama Depan',
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: softGreyColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(data.firstName),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Nama Belakang',
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: softGreyColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(data.lastName),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Alamat Email',
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: softGreyColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(data.email),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56),
                        color: blueColor),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const EditProfile();
                            });
                      },
                      child: Text(
                        'Ubah Data',
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginLoading) {
                        LoadingWidget(context).loading(true);
                      }
                      if (state is LoginInitial) {
                        LoadingWidget(context).loading(false);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 22),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(56),
                          color: redColor),
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          context.read<LoginCubit>().logout();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.exit_to_app_outlined,
                              color: whiteColor,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Log Out',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          },
        ),
      ),
    );
  }
}
