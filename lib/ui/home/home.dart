import 'package:ewallet_app/ui/history/history_page.dart';
import 'package:ewallet_app/ui/home/homepage.dart';
import 'package:ewallet_app/ui/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedTabIndex = 0;
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 24,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.description,
          size: 24,
        ),
        label: 'History'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.account_circle,
          size: 24,
        ),
        label: 'Profile'),
  ];

  void _onNavBarTapped(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  List pages = const [HomePage(), HistoryPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedTabIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: whiteColor,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        child: BottomNavigationBar(
          currentIndex: selectedTabIndex,
          onTap: _onNavBarTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          elevation: 0,
          selectedItemColor: orangeCOlor,
          unselectedItemColor: blackColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle:
              blueTextStyle.copyWith(fontSize: 10, fontWeight: medium),
          unselectedLabelStyle:
              blackTextStyle.copyWith(fontSize: 10, fontWeight: medium),
          items: items,
        ),
      ),
    );
  }
}
