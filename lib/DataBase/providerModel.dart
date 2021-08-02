import 'package:flutter/cupertino.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_ap/Tabs/TrasTab/TransactionTile.dart';

class TransactionProvider extends ChangeNotifier {
  int transactionId = 1;
  List<Transaction> transcations = [];
  List<DateTime> transactionsAllDates = [];
  List<Widget> get items => transcations
      .map((element) => TransactionTile(
            transaction: element,
          ))
      .toList();

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
          originAccount: res[i]['originAccount'],
          day: res[i]['day'],
          month: res[i]['month'],
          year: res[i]['year'],
          hour: res[i]['hour'],
          minute: res[i]['minute'],
          transactionType: res[i]['transactionType']);
      transcations.add(transaction);
    }
    print('added all');
    getAllDates();
    notifyListeners();
  }

  void increaseID() {
    transactionId++;
    notifyListeners();
  }

  List<Transaction> getOneDayTransactions(int day, int month, int year) {
    List<Transaction> oneDaytranscations = [];
    transcations.forEach((element) {
      if (element.day == day &&
          element.month == month &&
          element.year == year) {
        oneDaytranscations.add(element);
      }
    });
    return oneDaytranscations;
  }

  void getAllDates() {
    transactionsAllDates.clear();
    bool flag;
    transcations.forEach((element) {
      flag = false;
      DateTime temp = DateTime(element.year, element.month, element.day);
      transactionsAllDates.forEach((element) {
        if (temp.day == element.day && temp.month == element.month && temp.year == element.year) {
          flag = true;
        }
      });
      if (flag == false) {
        transactionsAllDates.add(temp);
      }
    });
    transactionsAllDates.sort((b,a) => a.compareTo(b));
  }

  double getOneDayIncome(List<Transaction> oneDaytranscations) {
    double totalIncome = 0;
    oneDaytranscations.forEach((element) {
      if (element.transactionType == 'Income') {
        totalIncome += element.price;
      }
    });
    return totalIncome;
  }

  double getOneDayExpense(List<Transaction> oneDaytranscations) {
    double totalExpense = 0;
    oneDaytranscations.forEach((element) {
      if (element.transactionType == 'Expense') {
        totalExpense += element.price;
      }
    });
    return totalExpense;
  }
}