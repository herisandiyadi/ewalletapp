import 'package:ewallet_app/cubit/profile/profile_cubit.dart';
import 'package:ewallet_app/models/update_request.dart';
import 'package:ewallet_app/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../shared/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          LoadingWidget(context).loading(true);
        } else if (state is UpdateProfileLoaded) {
          LoadingWidget(context).loading(false);
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: state.updateResponse.message,
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                width: 120,
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show();
        } else if (state is ProfileFailed) {
          LoadingWidget(context).loading(false);
          Alert(
            context: context,
            type: AlertType.error,
            title: "Failed",
            desc: state.message,
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
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
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        alignment: Alignment.center,
        content: Container(
          height: 326,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), color: lightbgColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ubah Data',
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                      hintText: 'Input your Last Name',
                      hintStyle: const TextStyle(color: softGreyColor)),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: orangeCOlor),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    context.read<ProfileCubit>().updateProfile(UpdateRequest(
                        firstName: firstnameController.text,
                        lastName: lastnameController.text));
                  },
                  child: Text(
                    'Ubah Data',
                    style: whiteTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
