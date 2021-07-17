import 'package:flutter/material.dart';
import 'package:money_manager_ap/Tabs/TrasTab/Indicator.dart';

class TotalBalanceIndicator extends StatefulWidget {
  @override
  _TotalBalanceIndicatorState createState() => _TotalBalanceIndicatorState();
}

class _TotalBalanceIndicatorState extends State<TotalBalanceIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        child: Row(
          children: [
            indicator('income', 8569.21),
            indicator('Expense', 8569.21),
            indicator('Total', 8569.21),
          ],
        ));
  }
}
