import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget_app/controllers/db_helper.dart';
import 'package:budget_app/screens/add_transaction.dart';
import 'package:budget_app/screens/historyPage.dart';
import 'package:budget_app/screens/mainPage.dart';
import 'package:budget_app/screens/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/ThemeStatic.dart' as Static;
import 'package:unicons/unicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  int _selectedIndex = 0;
  bool track = true;

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    MainPage(),
    SettingsPage(),
    HistryPage(),
    AddTransaction(),
  ];

  var iconList = [
    Icons.person,
    Icons.settings,
  ];

  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if (value['type'] == "Доход") {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Static.buttonColor,
        // elevation: 0,
      ),
      backgroundColor: Static.backgroundColor,
      //
      floatingActionButtonLocation: track
          ? FloatingActionButtonLocation.centerDocked
          : track != (_selectedIndex == 3)
              ? FloatingActionButtonLocation.centerFloat
              : FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (track == false) {
              _navigateBottomNavBar(0);
            } else {
              _navigateBottomNavBar(3);
            }
            track = !track;
          });
          // Navigator.of(context)
          //     .push(
          //   MaterialPageRoute(
          //     builder: (context) => AddTransaction(),
          //   ),
          // )
          //     .whenComplete(() {
          //   setState(() {});
          // });
        },
        backgroundColor: Static.buttonColor,
        child: Icon(
          track ? Icons.add : Icons.close,
          size: 32.0,
        ),
      ),
      //
      body: _children[_selectedIndex],
      //! bottom bar
      bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _selectedIndex,
          backgroundColor: Colors.white,
          inactiveColor: Colors.black,
          activeColor: Static.buttonColor,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: _navigateBottomNavBar),
      //other params
    );
  }
}
