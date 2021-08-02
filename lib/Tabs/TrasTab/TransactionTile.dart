import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Data.dart';

class TransactionTile extends StatefulWidget {
  final Transaction transaction;
  const TransactionTile({Key key, this.transaction}) : super(key: key);
  @override
  _TransactionTileState createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  widget.transaction.transactionType,
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.grey),
                ),
                alignment: Alignment.center,
              )),
          Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top : 8),
                        child: Text(
                          widget.transaction.note,
                          textScaleFactor: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(bottom : 8),
                        child: Text(
                          subTitleDeterminer(widget.transaction),
                          textScaleFactor: 1,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                child: Text(widget.transaction.price.toString()),
                alignment: Alignment.center,
              )),
        ],
      ),
    );
  }
}

// ignore: missing_return
String subTitleDeterminer(Transaction tr) {
  switch (tr.transactionType) {
    case 'Income':
      return tr.destenationAccount;
    case 'Expense':
      return tr.originAccount;
    case 'Total':
      return '${tr.originAccount} -> ${tr.destenationAccount}';
  }
}
