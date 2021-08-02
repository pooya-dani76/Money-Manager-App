import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/providerModel.dart';
import 'package:provider/provider.dart';

class TransactionTile extends StatefulWidget {
  final Transaction transaction;
  const TransactionTile({Key key, this.transaction}) : super(key: key);
  @override
  _TransactionTileState createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  @override
  Widget build(BuildContext context) {
    FlutterMoneyFormatter price =
        FlutterMoneyFormatter(amount: widget.transaction.price.toDouble());
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
                margin: EdgeInsets.only(right:8),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 8),
                        child: AutoSizeText(
                          widget.transaction.note,
                          textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              minFontSize: 11,
                              maxFontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 8),
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
                padding: EdgeInsets.only(right: 15, left: 3),
                  alignment: Alignment.centerRight,
                child: AutoSizeText('IRR ${price.output.nonSymbol}',
                    textScaleFactor: 1,
                    style: TextStyle(color: priceColor(widget.transaction)),
                    minFontSize: 5,
                    maxLines: 1,
                    maxFontSize: 15),
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

Color priceColor(Transaction transaction) {
  switch (transaction.transactionType) {
    case 'Expense':
      return Colors.red;

    case 'Income':
      return Colors.blue;

    case 'Transfer':
      return null;
  }
}
