import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:money_manager_ap/Tabs/Controllers.dart';
import 'package:money_manager_ap/Tabs/TrasTab/TransactionTile.dart';
import 'package:provider/provider.dart';
import 'TransactionHeader.dart';

class OneDayTransaction extends StatefulWidget {
  final List<Transaction> oneDayTransactions;
  final int day;
  final int month;
  final int year;
  const OneDayTransaction({
    Key key,
    this.oneDayTransactions,
    this.day,
    this.month,
    this.year,
  }) : super(key: key);

  @override
  _OneDayTransactionState createState() => _OneDayTransactionState();
}

class _OneDayTransactionState extends State<OneDayTransaction> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (BuildContext context, transactionProvider, Widget child) {
        return Container(
          height: (51 + (widget.oneDayTransactions.length * 55))
              .toDouble(),
          child: Column(
            children: [
              TransactionHeader(
                day: widget.day,
                month: widget.month,
                year: widget.year,
              ),
              Divider(height: 1,indent: 20, endIndent: 20,),
              Expanded(
                  child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  controller: listController,
                  itemBuilder: (context, index) {
                    return TransactionTile(
                      transaction: widget.oneDayTransactions[index],
                    );
                  },
                  itemCount: widget.oneDayTransactions.length,
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
