import 'package:budget_app/controllers/db_helper.dart';
import 'package:budget_app/modals/transaction_modal.dart';
import 'package:budget_app/screens/add_transaction.dart';
import 'package:budget_app/screens/historyPage.dart';
import 'package:budget_app/screens/widgets/confirmDialog.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/ThemeStatic.dart' as Static;
import 'package:hive/hive.dart';
import 'package:unicons/unicons.dart';
import '../controllers/db_helper.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DbHelper dbHelper = DbHelper();
  late Box box;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  var dataSet;
  var index;

  var iconList = [
    Icons.person,
    Icons.settings,
  ];

  List<String, int>(Map entireData) {
    print(entireData);
    dataSet = [];
    entireData.forEach((key, value) {
      print('a');
      if (value['type'] == "Расход") {
        print(value['note']);
        dataSet.add(
          {
            'domain': value['note'] as String,
            'measure': value['amount'] as int
          },
        );
      }
    });

    return dataSet!;
  }

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
    initState() {
      String firstName = 'Животное';
      String secondName = 'Машина';
      String threeName = 'Отдых';
      String fourName = 'Хобби';
      String fiveName = 'Учеба';
      String sixName = 'Такси';
      String sevenName = 'Животное';
      String eightName = 'Животное';
      String nineName = 'Животное';
      String tenName = 'Животное';
      String elevenName = 'Животное';
      String twelveName = 'Животное';
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        // elevation: 0,
      ),
      backgroundColor: Static.backgroundColor,
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
                child:
                    Text('Нажмите на + снизу и добавьте первые доходы и траты'),
              );
            }
            //
            getTotalBalance(snapshot.data!);
            return ListView(
              physics: NeverScrollableScrollPhysics(),
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
                              Color.fromARGB(255, 0, 9, 107),
                              // Color.fromARGB(255, 13, 28, 196),
                              // Color.fromARGB(255, 102, 149, 237),
                              Color.fromARGB(255, 0, 128, 255),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: totalBalance >= 100
                                    ? Colors.red.shade100
                                    : totalBalance == 0
                                        ? Colors.grey.shade500
                                        : totalBalance <= 100
                                            ? Colors.grey.shade500
                                            : Colors.green.shade100,
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
                          FittedBox(
                            child: Text(
                              '${totalBalance} грн',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: totalBalance <= -1
                                      ? Color.fromARGB(255, 229, 188, 187)
                                      : totalBalance >= 2500
                                          ? totalBalance >= 25000
                                              ? Color.fromARGB(255, 52, 197, 57)
                                              : Color.fromARGB(
                                                  255, 107, 207, 111)
                                          : Color.fromARGB(255, 194, 219, 194)),
                            ),
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
                //
                //
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      Text(
                        'Избранные категории',
                        style: TextStyle(
                            fontSize: size.height * 0.03,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 20, top: 20),
                        height: size.height * 0.50,
                        child: GridView.count(
                          primary: true,
                          childAspectRatio: 3 / 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          crossAxisCount: 3,
                          children: [
                            InkWell(
                              onLongPress: () async {
                                var answer = await testConfirmDialog(
                                    context,
                                    1,
                                    "ВНИМАНИЕ",
                                    "Меняем Название ${firstName}?");
                                if (answer != null) {
                                  setState(() {
                                    firstName = '${firstName}';
                                  });
                                }
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/cat.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      (firstName == '')
                                          ? 'Животное'
                                          : firstName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () async {
                                var answer = await testConfirmDialog(
                                    context,
                                    2,
                                    "ВНИМАНИЕ",
                                    "Меняем Название ${secondName}?");
                                if (answer != null) {
                                  setState(() {
                                    secondName = '${secondName}';
                                  });
                                }
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/car.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      (secondName == '')
                                          ? 'Машина'
                                          : secondName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/relax.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Отдых',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddTransaction()));
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/joystick.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Хобби',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/study.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Учеба',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/taxi.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Такси',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/cat.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Животные',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/cat.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Животные',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/cat.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Животные',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/cat.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Животные',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                print('hey');
                              },
                              onTap: () {
                                print('fuuu');
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(31, 119, 119, 119),
                                          offset: const Offset(0.0, 4.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icons/cat.png',
                                      height: size.height * 0.07,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'Животные',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
            FittedBox(
              child: Text(
                value,
                style: TextStyle(
                    // fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70),
              ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Расход',
              style: TextStyle(fontSize: 14.0, color: Colors.white70),
            ),
            FittedBox(
              child: Text(
                value,
                style: TextStyle(
                    // fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70),
              ),
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
