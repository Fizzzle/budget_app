import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/ThemeStatic.dart' as Static;
import 'package:flutter_switch/flutter_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

bool darkMode = false;
bool vibrationMode = true;

var dropVal = '1';
var dropLeng = 'ru';
var dropNoti = '7';
var dropValute = 'грн';

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e7ef),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: ListView(children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 9.0,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Темный режим',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    FlutterSwitch(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.height * 0.05,
                      valueFontSize: 15.0,
                      toggleSize: 20,
                      value: darkMode,
                      borderRadius: 30.0,
                      padding: 8,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          //
                          darkMode = !darkMode;
                        });
                      },
                    ),
                  ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 9.0,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Валюта',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: DropdownButtonFormField(
                        value: dropVal,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'грн',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            value: "1",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              ' \$ ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            value: "2",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '€',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            value: "3",
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            dropVal = '${val}';
                            print(dropVal);
                          });
                        }),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 9.0,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Выбор языка',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: DropdownButtonFormField(
                          icon: Icon(
                            Icons.flag,
                            color: (dropLeng == 'ru')
                                ? Colors.blue
                                : (dropLeng == 'ua')
                                    ? Colors.yellow
                                    : Colors.red,
                          ),
                          value: dropLeng,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                'русский',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              value: "ru",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Украинский',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              value: "ua",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Английский',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              value: "en",
                            ),
                          ],
                          onChanged: (val) {
                            setState(() {
                              dropLeng = '${val}';
                            });
                          }),
                    )
                  ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 9.0,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Вибрация',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    FlutterSwitch(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.height * 0.05,
                      valueFontSize: 15.0,
                      toggleSize: 20,
                      value: vibrationMode,
                      borderRadius: 30.0,
                      padding: 8,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          //
                          vibrationMode = !vibrationMode;
                        });
                      },
                    ),
                  ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 9.0,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Уведомления',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: DropdownButtonFormField(
                          value: dropNoti,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                '7 дней',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              value: "7",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                '14 дней',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              value: "14",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                '30 дней',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              value: "30",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "Никогда",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              value: 'false',
                            ),
                          ],
                          onChanged: (val) {
                            setState(() {
                              dropNoti = '${val}';
                              print(dropLeng);
                            });
                          }),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }

  var iconList = [
    Icons.person,
    Icons.settings,
  ];
}
