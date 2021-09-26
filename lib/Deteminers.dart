import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/Tabs/TrasTab/DailyPage.dart';

Map<String, Color> colors = {
  'Income': Colors.blue,
  'Expense': Colors.red,
  'Total': null
};

Map<int, Widget> transTabPages = {
  0: DailyPage(),
  1: Container(),
  2: Container(),
  3: Container(),
};

Map<int, String> monthes = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec',
};

// ignore: missing_return
String subTitleDeterminer(Transaction tr) {
  switch (tr.transactionType) {
    case 'Income':
      return tr.destenationAccount;
    case 'Expense':
      return tr.originAccount;
    case 'Transfer':
      return '${tr.originAccount} -> ${tr.destenationAccount}';
  }
}

Map<String, TextInputType> inputType = {
  'number': TextInputType.number,
  'text': TextInputType.text,
  'None': TextInputType.none,
  'MultiLine': TextInputType.multiline
};

Map<String, List<String>> getDataFormTitle = {
  'Income': ['To', 'For'],
  'Expense': ['From', 'For'],
  'Transfer': ['From', 'To']
};

Map<String , String> defaultValues = {
  'DropDown':'Expense',
  'OriginAccount' : '',
  'DestenationAccount':'',
  'Amount' : '',
  'Note' : '',
  'Description' : ''
};

Transaction defaultTransaction = Transaction(
    day: DateTime.now().day,
    month: DateTime.now().month,
    year: DateTime.now().year,
    hour: DateTime.now().hour,
    minute: DateTime.now().minute , 
    transactionType: 'Expense');


