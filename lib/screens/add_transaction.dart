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
  DateTime selectedDate = DateTime.now();
  bool track = false;

  //
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0.0,
        elevation: 0,
        leading: BackButton(),
        backgroundColor: Static.buttonColor,
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
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Static.buttonColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Text(
                    'Добавить',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.1,
                        padding: EdgeInsets.only(left: 20, top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: const Offset(0.0, 4.0),
                                blurRadius: 9.0,
                                spreadRadius: 1),
                          ],
                        ),
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.account_balance_wallet,

                            //   // color: Colors.greenAccent,
                            //   size: size.width * 0.1,
                            // ),
                            // labelText: "Введите сюда сумму...",
                            hintText: "0",
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            try {
                              amount = int.parse(val);
                            } catch (e) {}
                          },
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              label: Text(
                                "Доход",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: type == "Доход"
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              selectedColor: Color.fromARGB(255, 76, 176, 81),
                              shadowColor: Colors.grey,
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
                            height: size.height * 0.03,
                          ),
                          Expanded(
                            child: ChoiceChip(
                              label: Text(
                                "Расход",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: type == "Расход"
                                        ? Colors.white
                                        : Colors.black),
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
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            //
                            if (amount != null && note.isNotEmpty) {
                              //
                              DbHelper dbHelper = DbHelper();
                              dbHelper.addData(
                                  amount!, selectedDate, note, type);
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
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.05,
                // ),
                Container(
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                      color: Static.buttonColor,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(60))),
                  child: Container(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: GridView.count(
                      primary: true,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 3,
                      children: [
                        Text(
                          '1',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '2',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '3',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '4',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '5',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '6',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '8',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '9',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
      //other params
    );
  }

  var iconList = [
    Icons.person,
    Icons.settings,
  ];
}
