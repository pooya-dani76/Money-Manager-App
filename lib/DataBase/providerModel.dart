import 'package:flutter/cupertino.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_ap/Tabs/TrasTab/TransactionTile.dart';
import 'package:money_manager_ap/WidgetFunctions.dart';

class TransactionProvider extends ChangeNotifier {
  int transactionId = 1;
  List<Transaction> transcations = [];
  List<Widget> get items =>
      transcations.map((element) => TransactionTile(transaction: element,)).toList();

  void refresh() {
    notifyListeners();
  }

  void loadInfo() async {
    print('load info!');
    transcations.clear();
    print('cleared');
    var res;
    try {
      res = await readSQL();
    } catch (e) {
      print('error: $e');
    }
    print('Readed SQL');
    var rowCount = await getNumberOfRows();
    print(rowCount[0]['COUNT(*)']);
    for (int i = 0; i < rowCount[0]['COUNT(*)']; i++) {
      Transaction transaction = Transaction(
          transactionId: res[i]['id'],
          note: res[i]['note'],
          price: res[i]['price'],
          destenationAccount: res[i]['destenationAccount'],
          extraNote: res[i]['extraNote'],
          originAccount: res[i]['originAccount'] ,
          day : res[i]['day'],
          month : res[i]['month'],
          year : res[i]['year'],
          hour : res[i]['hour'],
          minute : res[i]['minute'],
          transactionType : res[i]['transactionType']);
      transcations.add(transaction);
    }
    print('added all');
    notifyListeners();
  }

  void increaseID() {
    transactionId++;
    notifyListeners();
  }
}
