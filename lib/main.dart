import 'package:budget_app/homepage.dart';
import 'package:budget_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('money');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Контроль Расходов и Доходов',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
