import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e7ef),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Язык :',
                  style: TextStyle(fontSize: 23),
                ),
                Text('Русский', style: TextStyle(fontSize: 23))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Тема :',
                  style: TextStyle(fontSize: 23),
                ),
                Text('Светлая', style: TextStyle(fontSize: 23))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Уведомления раз в :',
                  style: TextStyle(fontSize: 23),
                ),
                Text('7 дней', style: TextStyle(fontSize: 23))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Валюта :',
                  style: TextStyle(fontSize: 23),
                ),
                Text('грн', style: TextStyle(fontSize: 23))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text('СБРОСИТЬ ДОХОДЫ И РАСХОДЫ',
                    style: TextStyle(fontSize: 18)))
          ],
        ),
      ),
    );
  }

  var iconList = [
    Icons.person,
    Icons.settings,
  ];
}
