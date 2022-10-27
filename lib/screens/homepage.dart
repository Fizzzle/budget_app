import 'package:budget_app/controllers/db_helper.dart';
import 'package:budget_app/screens/add_transaction.dart';
import 'package:flutter/material.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddTransaction(),
            ),
          )
              .whenComplete(() {
            setState(() {});
          });
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
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
                child: Text('Ошибка'),
              );
            }
            //
            getTotalBalance(snapshot.data!);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.settings,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                      Text('Добро Пожаловать'),
                      // Кнопка Сеттинга
                      Icon(
                        Icons.settings,
                        size: 32,
                      ),
                    ],
                  ),
                ),
                // Дальшее
                Container(
                  width: size.width * 0.9,
                  margin: EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.blue,
                        ],
                      ),
                    ),
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
                          height: 20,
                        ),
                        Text(
                          '${totalBalance} грн',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
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
                //
                //
                //
                //
                //
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Последние действия',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map dataAtIndex = snapshot.data![index];
                      // if (dataAtIndex['type'] == "Доход") {
                      return expenseTile(120, 'note');
                      // } else {
                      //   Text('hey');
                      // }
                    })
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
              Icons.arrow_downward,
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
              Icons.arrow_upward,
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

  // !виджет последних действий
  //
  Widget expenseTile(int value, String note) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(children: [
        Row(
          children: [
            Icon(
              Icons.arrow_circle_up_outlined,
              size: 33,
              color: Colors.green[900],
            )
          ],
        ),
      ]),
    );
  }
}
