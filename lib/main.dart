import 'package:ewallet_app/cubit/balance/balance_cubit.dart';
import 'package:ewallet_app/cubit/history/history_cubit.dart';
import 'package:ewallet_app/cubit/login/login_cubit.dart';
import 'package:ewallet_app/cubit/profile/profile_cubit.dart';
import 'package:ewallet_app/cubit/register/register_cubit.dart';
import 'package:ewallet_app/cubit/transaction/transaction_cubit.dart';
import 'package:ewallet_app/services/auth/login_repository.dart';
import 'package:ewallet_app/services/auth/registration_repository.dart';
import 'package:ewallet_app/services/history/history_repository.dart';
import 'package:ewallet_app/services/profile/profile_repository.dart';
import 'package:ewallet_app/services/saldo/balance_repository.dart';
import 'package:ewallet_app/services/transaction/transaction_repository.dart';
import 'package:ewallet_app/ui/home/home.dart';
import 'package:ewallet_app/ui/home/homepage.dart';
import 'package:ewallet_app/ui/loginpage.dart';
import 'package:ewallet_app/ui/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(RegistrationRepository()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(LoginRepository()),
        ),
        BlocProvider(
          create: (context) => BalanceCubit(BalanceRepository()),
        ),
        BlocProvider(
          create: (context) => TransactionCubit(TransactionRepository()),
        ),
        BlocProvider(
          create: (context) => HistoryCubit(HistoryRepository()),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(ProfileRepository()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E Wallet App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const Home(),
          '/homepage': (context) => const HomePage(),
        },
      ),
    );
  }
}
