import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:money_manager_ap/DataBase/providerModel.dart';
import 'package:money_manager_ap/Tabs/TrasTab/OneDayTransaction.dart';
import 'package:provider/provider.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  @override
  void initState() {
    var provider = Provider.of<TransactionProvider>(context, listen: false);
    provider.loadInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Money Manager'),),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _incrementCounter(provider),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        body: Consumer<TransactionProvider>(
          builder: (context, transactionProvider, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return OneDayTransaction(
                  day: transactionProvider.transactionsAllDates[index].day,
                  month: transactionProvider.transactionsAllDates[index].month,
                  year: transactionProvider.transactionsAllDates[index].year,
                  oneDayTransactions: transactionProvider.getOneDayTransactions(
                      transactionProvider.transactionsAllDates[index].day,
                      transactionProvider.transactionsAllDates[index].month,
                      transactionProvider.transactionsAllDates[index].year),
                );
              },
              itemCount: transactionProvider.transactionsAllDates.length,
            );
          },
        ));
  }
}

void _incrementCounter(TransactionProvider provider) async {
  var insertor;
  checkTableExist();
  try {
    insertor = await insertTranscation(Transaction(
        transactionId: 1,
        note: 'for Transport',
        price: 12000,
        destenationAccount: 'Transportation',
        extraNote: 'from home to work',
        originAccount: 'Cash',
        year: 2021,
        month: 9,
        day: 20,
        hour: 17,
        minute: 30,
        transactionType: 'Income'));
  } catch (e) {
    print('Error3: $e');
  }

  print(insertor);
  provider.loadInfo();
}
