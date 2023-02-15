import 'package:ewallet_app/cubit/balance/balance_cubit.dart';
import 'package:ewallet_app/cubit/profile/profile_cubit.dart';
import 'package:ewallet_app/ui/amount/amount_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../shared/shared_methods.dart';
import '../../shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void fullNm() {
    context.read<ProfileCubit>().getProfile();
  }

  void cekSaldo() {
    context.read<BalanceCubit>().getSaldo();
  }

  @override
  void initState() {
    super.initState();
    fullNm();
    cekSaldo();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 80, bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang,',
                  style:
                      greyTextStyle.copyWith(fontSize: 16, fontWeight: regular),
                ),
                const SizedBox(
                  height: 2,
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ProfileLoaded) {
                      return Text(
                        '${state.profileResponse.data.firstName} ${state.profileResponse.data.lastName} ',
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: semiBold),
                      );
                    }
                    return const Text('');
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget card() {
      return Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: orangeCOlor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo',
                      style: whiteTextStyle.copyWith(fontSize: 14),
                    ),
                    BlocBuilder<BalanceCubit, BalanceState>(
                      builder: (context, state) {
                        if (state is BalanceLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is BalanceLoaded) {
                          return Text(
                            formatCurrency(
                                state.responseBalance.data.balance ?? 0),
                            style: whiteTextStyle.copyWith(
                                fontSize: 24, fontWeight: semiBold),
                          );
                        }
                        return Text(
                          formatCurrency(0),
                          style: whiteTextStyle.copyWith(
                              fontSize: 24, fontWeight: semiBold),
                        );
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: cekSaldo,
                child: const Card(
                  color: whiteColor,
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.sync,
                      size: 24,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget menu() {
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AmountPage(
                              title: 'Top Up',
                            )));
              },
              child: Card(
                color: blueColor,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wallet_rounded,
                        size: 48,
                        color: whiteColor,
                      ),
                      Text(
                        'Top Up',
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AmountPage(
                              title: 'Transfer',
                            )));
              },
              child: Card(
                color: greenColor,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sync_alt,
                        size: 48,
                        color: whiteColor,
                      ),
                      Text(
                        'Transfer',
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget promo() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Promo',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  child: Row(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/promo1.jpg',
                            width: 300,
                            height: 150,
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/promo2.jpg',
                            width: 300,
                            height: 150,
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/promo3.jpg',
                            width: 300,
                            height: 150,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              header(),
              card(),
              menu(),
              promo(),
            ],
          ),
          Positioned(
            top: -100,
            left: -30,
            right: -30,
            child: Image.asset(
              'assets/images/logos.png',
              height: 280,
            ),
          ),
        ],
      ),
    );
  }
}
