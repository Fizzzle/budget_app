import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var firstName;
var secondName;
var threeName;
var fourName;
var fiveName;
var sixName;
var sevenName;
var eightName;
var nineName;
var tenName;
var elevenName;
var twelveName;

testConfirmDialog(
    BuildContext context, int index, String title, String content) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextField(
          maxLength: 10,
          decoration: InputDecoration(
            icon: Icon(
              Icons.add_comment,
              // color: Colors.red,
              size: MediaQuery.of(context).size.height * 0.05,
            ),
            hintText: "Сюда пишите название",
            border: InputBorder.none,
          ),
          onChanged: (val) {
            if (index == 1) {
              firstName = val;
            } else if (index == 2) {
              secondName = val;
              //
            } else if (index == 3) {
              threeName = val;
              //
            } else if (index == 4) {
              fourName = val;
              //
            } else if (index == 5) {
              fiveName = val;
              //
            } else if (index == 6) {
              sixName = val;
              //
            } else if (index == 7) {
              sevenName = val;
              //
            } else if (index == 8) {
              eightName = val;
              //
            } else if (index == 9) {
              nineName = val;
              //
            } else if (index == 10) {
              tenName = val;
              //
            } else if (index == 11) {
              elevenName = val;
              //
            } else if (index == 12) {
              twelveName = val;
              //
            }
          },
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        ElevatedButton(
          onPressed: () {
            if (index == 1) {
              Navigator.of(context).pop(firstName);
            } else if (index == 2) {
              Navigator.of(context).pop(secondName);
            } else if (index == 3) {
              Navigator.of(context).pop(threeName);
            } else if (index == 4) {
              Navigator.of(context).pop(fourName);
            } else if (index == 5) {
              Navigator.of(context).pop(fiveName);
            } else if (index == 6) {
              Navigator.of(context).pop(sixName);
            } else if (index == 7) {
              Navigator.of(context).pop(eightName);
            } else if (index == 8) {
              Navigator.of(context).pop(sevenName);
            } else if (index == 9) {
              Navigator.of(context).pop(nineName);
            } else if (index == 10) {
              Navigator.of(context).pop(tenName);
            } else if (index == 11) {
              Navigator.of(context).pop(elevenName);
            } else if (index == 12) {
              Navigator.of(context).pop(twelveName);
            }
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 13, 93, 252))),
          child: Text("Изменить"),
        ),
      ],
    ),
  );
}
