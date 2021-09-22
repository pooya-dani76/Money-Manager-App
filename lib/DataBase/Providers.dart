import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_ap/Deteminers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionProvider extends ChangeNotifier {
  int transactionId = 1;
  List<Transaction> transcations = [];
  List<DateTime> transactionsAllDates = [];

  void refresh() {
    notifyListeners();
  }

  void loadInfo() async {
    transcations.clear();
    var res;
    try {
      res = await readSQL();
    } catch (e) {
      print('error: $e');
    }
    var rowCount = await getNumberOfRows();
    print(rowCount[0]['COUNT(*)']);
    for (int i = 0; i < rowCount[0]['COUNT(*)']; i++) {
      Transaction transaction = Transaction(
          transactionId: res[i]['id'],
          note: res[i]['note'],
          price: res[i]['price'],
          destenationAccount: res[i]['destenationAccount'],
          description: res[i]['description'],
          originAccount: res[i]['originAccount'],
          day: res[i]['day'],
          month: res[i]['month'],
          year: res[i]['year'],
          hour: res[i]['hour'],
          minute: res[i]['minute'],
          transactionType: res[i]['transactionType']);
      transcations.add(transaction);
    }
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
        if (temp.day == element.day &&
            temp.month == element.month &&
            temp.year == element.year) {
          flag = true;
        }
      });
      if (flag == false) {
        transactionsAllDates.add(temp);
      }
    });
    transactionsAllDates.sort((b, a) => a.compareTo(b));
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

class ThemeSetter extends ChangeNotifier {
  bool darkMode;

  void toggleTheme() async {
    final themeSaver = await SharedPreferences.getInstance();
    darkMode = !darkMode;
    themeSaver.setBool('ThemeData', darkMode);
    notifyListeners();
  }

  void loadTheme() async {
    final themeLoader = await SharedPreferences.getInstance();
    darkMode = themeLoader.getBool('ThemeData') ?? false;
    notifyListeners();
  }
}

class Controllers extends ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController originAccountController = TextEditingController();
  TextEditingController destenationAccountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> originAccountKey = GlobalKey<FormState>();
  GlobalKey<FormState> destenationAccountKey = GlobalKey<FormState>();
  GlobalKey<FormState> amountKey = GlobalKey<FormState>();
  String choosenValueForDropDown;
  var picker = ImagePicker();
  List<File> images = [];

  void setInitialValues(Transaction transaction) {
    setDate(DateTime(transaction.year, transaction.month, transaction.day,
        transaction.hour, transaction.minute));
    setTime(DateTime(transaction.year, transaction.month, transaction.day,
        transaction.hour, transaction.minute));
    originAccountController.text = transaction.originAccount != null
        ? transaction.originAccount
        : defaultValues['OriginAccount'];

    destenationAccountController.text = transaction.originAccount != null
        ? transaction.destenationAccount
        : defaultValues['DestentaionAccount'];

    amountController.text = transaction.price != null
        ? transaction.price.toString()
        : defaultValues['Amount'];

    noteController.text =
        transaction.note != null ? transaction.note : defaultValues['Note'];

    descriptionController.text = transaction.description != null
        ? transaction.description
        : defaultValues['Description'];
    choosenValueForDropDown = transaction.transactionType != null
        ? transaction.transactionType
        : defaultValues['DropDown'];
  }

  void disposeAllControllers() {
    originAccountController.clear();
    destenationAccountController.clear();
    amountController.clear();
    noteController.clear();
    descriptionController.clear();
  }

  void setDate(DateTime date) {
    dateController.text = '${date.year}-${date.month}-${date.day}';
  }

  void setTime(DateTime date) {
    timeController.text = '${date.hour}:${date.minute}';
  }

  DateTime extractDateTime() {
    var dateElements = dateController.text.split("-");
    var timeElements = timeController.text.split(":");
    DateTime tempDate;
    try {
      tempDate = DateTime(
          int.parse(dateElements[0]),
          int.parse(dateElements[1]),
          int.parse(dateElements[2]),
          int.parse(timeElements[0]),
          int.parse(timeElements[1]));
    } catch (e) {
      print(e);
    }
    return tempDate;
  }

  void addImage(File image) {
    images.add(image);
    notifyListeners();
  }

  void removeImageIndex(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  void setDropDownValue(String value) {
    choosenValueForDropDown = value;
    notifyListeners();
  }

  bool validateFields() {
    if (originAccountKey.currentState.validate() &&
        destenationAccountKey.currentState.validate() &&
        amountKey.currentState.validate()) return true;
    return false;
  }

  void addCurrentTransactionToDataBase() {
    List<String> dateParameters = dateController.text.split('-');
    List<String> timeParameters = timeController.text.split(':');
    try {
      insertTranscation(Transaction(
        transactionType: choosenValueForDropDown,
        day: int.parse(dateParameters[2]),
        month: int.parse(dateParameters[1]),
        year: int.parse(dateParameters[0]),
        hour: int.parse(timeParameters[0]),
        minute: int.parse(timeParameters[1]),
        originAccount: originAccountController.text,
        destenationAccount: destenationAccountController.text,
        price: double.parse(amountController.text),
        note: noteController.text,
        description: descriptionController.text,
      ));
    } catch (e) {
      print(e);
    }
  }
}
