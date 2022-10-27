import 'package:budget_app/controllers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  //
  int? amount;
  String note = "Траты";
  String type = "Доход";
  DateTime selectedDate = DateTime.now();

  //
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
            Navigator.pop(context);
          },
          backgroundColor: Colors.black,
          child: Icon(
            Icons.close,
            size: 32.0,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all((12.0)),
          children: [
            Text(
              'Добавить Транзакцию',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.add_task,
                  color: Colors.red,
                  size: 26,
                ),
                hintText: "0",
                border: InputBorder.none,
              ),
              onChanged: (val) {
                try {
                  amount = int.parse(val);
                } catch (e) {}
              },
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              maxLength: 24,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.new_releases_outlined,
                  color: Colors.red,
                  size: 26,
                ),
                hintText: "На что потрачено?",
                border: InputBorder.none,
              ),
              onChanged: (val) {
                note = val;
              },
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Text(
                      "Доход",
                      style: TextStyle(
                          fontSize: 30,
                          color: type == "Доход" ? Colors.white : Colors.black),
                    ),
                    selectedColor: Color.fromARGB(255, 76, 176, 81),
                    selected: type == "Доход" ? true : false,
                    onSelected: (val) {
                      if (val) {
                        setState(() {
                          type = "Доход";
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ChoiceChip(
                    label: Text(
                      "Расход",
                      style: TextStyle(
                          fontSize: 30,
                          color:
                              type == "Расход" ? Colors.white : Colors.black),
                    ),
                    selectedColor: Color.fromARGB(255, 255, 57, 57),
                    selected: type == "Расход" ? true : false,
                    onSelected: (val) {
                      if (val) {
                        setState(() {
                          type = "Расход";
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  //
                  if (amount != null && note.isNotEmpty) {
                    //
                    DbHelper dbHelper = DbHelper();
                    dbHelper.addData(amount!, selectedDate, note, type);
                    Navigator.of(context).pop();
                  } else {
                    print("Not all Value Proveded");
                  }
                },
                child: Text("Внести",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)))
          ],
        ));
  }
}
