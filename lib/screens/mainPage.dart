import 'package:budget_app/controllers/db_helper.dart';
import 'package:budget_app/screens/add_transaction.dart';
import 'package:budget_app/screens/historyPage.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/ThemeStatic.dart' as Static;
import 'package:unicons/unicons.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DbHelper dbHelper = DbHelper();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  var spandingList = [
    {'domain': 'Всякое', 'measure': 28},
    {'domain': 'Траты', 'measure': 27},
    {'domain': 'Машина', 'measure': 20},
    {'domain': 'Такси', 'measure': 5},
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
        // elevation: 0,
      ),
      backgroundColor: Color(0xffe2e7ef),
      body: FutureBuilder<Map>(
        future: dbHelper.fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Временно'),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('Данные пустые'),
              );
            }
            //
            getTotalBalance(snapshot.data!);
            return ListView(
              children: [
                // Дальшее
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HistryPage()));
                  },
                  child: Container(
                    width: size.width * 0.9,
                    margin: EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 143, 68, 255),
                              Color.fromARGB(255, 99, 68, 255),
                              Color.fromARGB(255, 68, 84, 255),
                              Color.fromARGB(255, 68, 127, 255),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                offset: const Offset(4.0, 4.0),
                                blurRadius: 9.0,
                                spreadRadius: 7)
                          ]),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'Общий Баланс',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            '${totalBalance} грн',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: totalBalance <= 0
                                    ? Color.fromARGB(255, 229, 188, 187)
                                    : totalBalance >= 2500
                                        ? totalBalance >= 25000
                                            ? Color.fromARGB(255, 52, 197, 57)
                                            : Color.fromARGB(255, 107, 207, 111)
                                        : Color.fromARGB(255, 194, 219, 194)),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(totalIncome.toString()),
                                cardExpens(totalExpense.toString())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //
                //
                //
                Container(
                  height: size.height * 0.3,
                  child: DChartPie(
                    data: [
                      {'domain': 'Всякое', 'measure': 28},
                      {'domain': 'Еда', 'measure': 27},
                      {'domain': 'Машина', 'measure': 20},
                      {'domain': 'Такси', 'measure': 5},
                    ],
                    fillColor: (pieData, index) {
                      switch (pieData['domain']) {
                        case 'Всякое':
                          return Colors.grey;
                        case 'Еда':
                          return Colors.green;
                        case 'Машина':
                          return Colors.blue;
                        case 'Такси':
                          return Colors.red;
                      }
                    },
                    // labelPosition: PieLabelPosition.outside,
                    labelColor: Colors.black,
                    labelFontSize: 14,
                    labelLineColor: Colors.black,
                    labelLineThickness: 3,
                    labelLinelength: 26,
                    labelPadding: 2,
                    strokeWidth: 5,
                    animate: true,
                    pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
                      return pieData['domain'] +
                          ':\n' +
                          pieData['measure'].toString();
                    },
                  ),
                ),
                //
                //
                Column(
                  children: [
                    Text(
                      'Популярные категории',
                      style: TextStyle(
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      height: size.height * 0.15,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: size.width * 0.2,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.car_crash,
                                  size: 53,
                                ),
                                Text('Машина'),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.2,
                            child: Column(
                              children: [
                                Icon(
                                  UniconsLine.shopping_cart_alt,
                                  size: 53,
                                ),
                                Text('Шопинг'),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.2,
                            child: Column(
                              children: [
                                Icon(
                                  UniconsLine.bus,
                                  size: 53,
                                ),
                                Text('Транспорт'),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.2,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.car_crash,
                                  size: 53,
                                ),
                                Text('Машина'),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.2,
                            child: Column(
                              children: [
                                Icon(
                                  UniconsLine.shopping_cart_alt,
                                  size: 53,
                                ),
                                Text('Шопинг'),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.2,
                            child: Column(
                              children: [
                                Icon(
                                  UniconsLine.bus,
                                  size: 53,
                                ),
                                Text('Транспорт'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Временно'),
            );
          }
        },
      ),
    );
  }

// ! Текст плюса
  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(6.0),
            child: Icon(
              Icons.arrow_upward,
              size: 28,
              color: Colors.greenAccent,
            ),
            margin: EdgeInsets.only(
              right: 8,
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Доходы',
              style: TextStyle(fontSize: 14.0, color: Colors.white70),
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

// ! Текст минуса
  Widget cardExpens(String value) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(6.0),
            child: Icon(
              Icons.arrow_downward,
              size: 28,
              color: Colors.redAccent,
            ),
            margin: EdgeInsets.only(
              right: 8,
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Расход',
              style: TextStyle(fontSize: 14.0, color: Colors.white70),
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  // !виджет последних действий расход
  //
  Widget expenseTile(int value, String note) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 195, 195),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_downward,
                size: 33,
                color: Colors.red[900],
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Расход',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Text(
            "- $value грн",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  // !Виджет последних действий доход
  Widget IncomeTile(int value, String note) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 196, 233, 195),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_upward,
                size: 33,
                color: Colors.green[900],
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Доход',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Text(
            "+ $value грн",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
