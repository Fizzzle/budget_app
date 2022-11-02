import 'package:budget_app/controllers/db_helper.dart';
import 'package:budget_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budget_app/ThemeStatic.dart' as Static;

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  //
  int? amount;
  String note = "Разное";
  String type = "Доход";
  bool reasonNote = false;
  DateTime selectedDate = DateTime.now();
  bool track = false;

  //
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        // elevation: 0,
      ),
      backgroundColor: Static.backgroundColor,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   backgroundColor: Static.PrimaryMaterialColor,
      //   child: Icon(
      //     Icons.close,
      //     size: 32.0,
      //   ),
      // ),
      body: ListView(
        padding: EdgeInsets.all((12.0)),
        children: [
          Text(
            'Добавить',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              icon: Icon(
                Icons.account_balance_wallet,
                // color: Colors.greenAccent,
                size: size.height * 0.05,
              ),
              labelText: "Введите сюда сумму...",
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
            height: size.height * 0.02,
          ),
          reasonNote
              ? TextField(
                  maxLength: 24,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.add_comment,
                      // color: Colors.red,
                      size: size.height * 0.05,
                    ),
                    hintText: "На что потрачено?",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    note = val;
                  },
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
                )
              : SizedBox(
                  height: size.height * 0.03,
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
                  shadowColor: Colors.grey,
                  selected: type == "Доход" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Доход";
                        reasonNote = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Expanded(
                child: ChoiceChip(
                  label: Text(
                    "Расход",
                    style: TextStyle(
                        fontSize: 30,
                        color: type == "Расход" ? Colors.white : Colors.black),
                  ),
                  selectedColor: Color.fromARGB(255, 255, 57, 57),
                  selected: type == "Расход" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Расход";
                        reasonNote = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () async {
              //
              if (amount != null && note.isNotEmpty) {
                //
                DbHelper dbHelper = DbHelper();
                dbHelper.addData(amount!, selectedDate, note, type);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
                setState(() {
                  track = !track;
                });
              } else {
                print("Not all Value Proveded");
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Static.buttonColor, // background
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Внести",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      //other params
    );
  }

  var iconList = [
    Icons.person,
    Icons.settings,
  ];
}
