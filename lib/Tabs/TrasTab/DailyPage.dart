import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:money_manager_ap/DataBase/providerModel.dart';
import 'package:provider/provider.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(provider),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
        body:Consumer<TransactionProvider>(builder: (context , transaction , child){
          return ListView(
            children: transaction.items,
          );
        },) );
  }
}

void _incrementCounter(TransactionProvider provider) async {
    int b;
    // ignore: unused_local_variable
    var c, a;

    try {
      final db = SqliteDB();
      b = await db.countTable();
    } catch (e) {
      print('Error1: $e');
    }

    if (b == 0) {
      try {
        c = await createTable();
      } catch (e) {
        print('Error2: $e');
      }
    }

    try {
      a = await insertTranscation(Transaction(
        transactionId: 1,
        note: 'sik',
        price: 8569,
        destenationAccount: 'got',
        extraNote: 'Goto sikim',
        originAccount: 'sik',
        year: 2020,
        month: 9 ,
        day: 20 ,
        hour: 17 ,
        minute: 30,
        transactionType: 'income'
      ));
    } catch (e) {
      print('Error3: $e');
    }

    print(a);
    provider.loadInfo();
  }
