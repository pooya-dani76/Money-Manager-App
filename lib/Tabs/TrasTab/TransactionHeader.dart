import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:money_manager_ap/Deteminers.dart';
import 'package:provider/provider.dart';

class TransactionHeader extends StatefulWidget {
  final double radius;
  final int day;
  final int month;
  final int year;
  const TransactionHeader(
      {Key key, this.radius, this.day, this.month, this.year})
      : super(key: key);

  @override
  _TransactionHeaderState createState() => _TransactionHeaderState();
}

class _TransactionHeaderState extends State<TransactionHeader> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TransactionProvider>(context);
    FlutterMoneyFormatter expense = FlutterMoneyFormatter(
        amount: provider.getOneDayExpense(provider.getOneDayTransactions(
            widget.day, widget.month, widget.year)));
    FlutterMoneyFormatter income = FlutterMoneyFormatter(
        amount: provider.getOneDayIncome(provider.getOneDayTransactions(
            widget.day, widget.month, widget.year)));
    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 0),
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 5, left: 20),
                    child: Text(
                      // dayReturner(date.day),
                      widget.day.toString(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 0, top: 10),
                          child: AutoSizeText(
                            '${monthes[widget.month]} ${widget.year}',
                            textScaleFactor: 1,
                            minFontSize: 1,
                            maxLines: 1,
                            maxFontSize: 10,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10, top: 0),
                          child: AutoSizeText(
                            'Mon',
                            textScaleFactor: 1,
                            minFontSize: 1,
                            maxLines: 1,
                            maxFontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.8,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(left: 10, right: 15),
                      child: AutoSizeText(
                        'IRR ${income.output.nonSymbol}',
                        style: TextStyle(color: Colors.blue),
                        textScaleFactor: 1,
                        minFontSize: 10,
                        maxLines: 1,
                        maxFontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(left: 10, right: 15),
                      child: AutoSizeText(
                        'IRR ${expense.output.nonSymbol}',
                        style: TextStyle(color: Colors.red),
                        textScaleFactor: 1,
                        minFontSize: 5,
                        maxLines: 1,
                        maxFontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
