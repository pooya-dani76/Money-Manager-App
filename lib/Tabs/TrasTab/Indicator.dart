import 'package:flutter/material.dart';

Widget indicator(String type, double price) {
  return Container(
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '$type',
              textScaleFactor: 1,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '$price',
              textScaleFactor: 1,
              style: TextStyle(color: colorDeterminer(type)),
            ),
          ),
        ),
      ],
    ),
  );
}

// ignore: missing_return
Color colorDeterminer(String type) {
  switch (type) {
    case 'income':
      return Colors.blue;
    case 'Expense':
      return Colors.red;
    case 'Total':
      return null;
  }
}
