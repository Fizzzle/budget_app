import 'package:flutter/material.dart';

final buttonColor = Color.fromARGB(255, 0, 149, 255);
final backgroundColor = Color(0xffe2e7ef);

MaterialColor PrimaryMaterialColor = MaterialColor(
  4278717375,
  <int, Color>{
    50: Color.fromRGBO(
      8,
      11,
      191,
      .1,
    ),
    100: Color.fromRGBO(
      8,
      11,
      191,
      .2,
    ),
    200: Color.fromRGBO(
      8,
      11,
      191,
      .3,
    ),
    300: Color.fromRGBO(
      8,
      11,
      191,
      .4,
    ),
    400: Color.fromRGBO(
      8,
      11,
      191,
      .5,
    ),
    500: Color.fromRGBO(
      8,
      11,
      191,
      .6,
    ),
    600: Color.fromRGBO(
      8,
      11,
      191,
      .7,
    ),
    700: Color.fromRGBO(
      8,
      11,
      191,
      .8,
    ),
    800: Color.fromRGBO(
      8,
      11,
      191,
      .9,
    ),
    900: Color.fromRGBO(
      8,
      11,
      191,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "Inter",
  primaryColor: Color(0xff080bbf),
  primarySwatch: PrimaryMaterialColor,
);
