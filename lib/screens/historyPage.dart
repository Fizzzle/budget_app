import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget_app/modals/transaction_modal.dart';
import 'package:budget_app/screens/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/ThemeStatic.dart' as Static;
import 'package:hive/hive.dart';

import '../controllers/db_helper.dart';
import 'add_transaction.dart';

class HistryPage extends StatefulWidget {
  const HistryPage({super.key});

  @override
  State<HistryPage> createState() => _HistryPageState();
}

class _HistryPageState extends State<HistryPage> {
  DbHelper dbHelper = DbHelper();
  late Box box;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  List<String> months = [
    "Января",
    "Февраля",
    "Марта",
    "Апреля",
    "Мая",
    "Июня",
    "Июля",
    "Августа",
    "Сентября",
    "Октября",
    "Ноября",
    "Декабря"
  ];

  var iconList = [
    Icons.person,
    Icons.settings,
  ];

  getTotalBalance(List<TransactionModal> entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    // entireData.forEach((key, value) {
    //   if (value['type'] == "Доход") {
    //     totalBalance += (value['amount'] as int);
    //     totalIncome += (value['amount'] as int);
    //   } else {
    //     totalBalance -= (value['amount'] as int);
    //     totalExpense += (value['amount'] as int);
    //   }
    // });
    for (TransactionModal data in entireData) {
      if (data.type == "Доход") {
        totalBalance += data.amount;
        totalIncome += data.amount;
      } else {
        totalBalance -= data.amount;
        totalExpense += data.amount;
      }
    }
  }

  Future<List<TransactionModal>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModal> items = [];
      box.toMap().values.forEach(((element) => {
            items.add(TransactionModal(
              element['amount'] as int,
              element['date'] as DateTime,
              element['note'],
              element['type'],
            ))
          }));
      return items;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box('money');
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(),
      ),
      backgroundColor: Color(0xffe2e7ef),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Static.PrimaryMaterialColor,
        child: Icon(
          Icons.close,
          size: 32.0,
        ),
      ),
      body: FutureBuilder<List<TransactionModal>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Случилась какая то ошибка'),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('Данных пока нет'),
              );
            }
            //

            return ListView(
              children: [
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
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // Map dataAtIndex = snapshot.data![index];
                      TransactionModal dataAtIndex;
                      //
                      try {
                        //
                        dataAtIndex = snapshot.data![index];
                      } catch (e) {
                        //
                        return Container();
                      }

                      if (dataAtIndex.type == "Доход") {
                        return IncomeTile(
                          dataAtIndex.amount,
                          dataAtIndex.note,
                          dataAtIndex.date,
                          index,
                        );
                      } else {
                        return expenseTile(
                          dataAtIndex.amount,
                          dataAtIndex.note,
                          dataAtIndex.date,
                          index,
                        );
                        //   Text('hey');
                        // }
                      }
                    }),
              ],
            );
          } else {
            return Center(
              child: Text('Что то пошло не так'),
            );
          }
        },
      ),
    );
  }

  // !виджет последних действий расход
  //
  Widget expenseTile(int value, String note, DateTime data, int index) {
    return InkWell(
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
            context, "ВНИМАНИЕ", "ТЫ ХОЧЕШЬ УДАЛИТЬ ЭТУ ЗАПИСЬ?");
        if (answer != null && answer) {
          //
          dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
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
                Column(
                  children: [
                    Row(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.013,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        '${data.day} ${months[data.month - 1]}',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "- $value грн",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Text(
                  "$note",
                  style: TextStyle(fontSize: 24, color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // !Виджет последних действий доход
  Widget IncomeTile(int value, String note, DateTime data, int index) {
    return InkWell(
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
            context, "ВНИМАНИЕ", "ТЫ ХОЧЕШЬ УДАЛИТЬ ЭТУ ЗАПИСЬ?");
        if (answer != null && answer) {
          //
          dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
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
                Column(
                  children: [
                    Row(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.013,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        '${data.day} ${months[data.month - 1]}',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "+ $value грн",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
