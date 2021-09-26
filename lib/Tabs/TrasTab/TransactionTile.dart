import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/Deteminers.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/GetDataPage.dart';

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
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GetDataPage(transaction: widget.transaction))),
      child: Container(
        height: 55,
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
                  margin: EdgeInsets.only(right: 8),
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
                      style: TextStyle(
                          color:
                              colors['${widget.transaction.transactionType}']),
                      minFontSize: 5,
                      maxLines: 1,
                      maxFontSize: 15),
                )),
          ],
        ),
      ),
    );
  }
}
