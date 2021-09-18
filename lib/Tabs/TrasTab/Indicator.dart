import 'package:flutter/material.dart';

import '../../Deteminers.dart';

Widget indicator(String transactionType, double price) {
  return Container(
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '$transactionType',
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
              style: TextStyle(color: colors['$transactionType']),
            ),
          ),
        ),
      ],
    ),
  );
}

