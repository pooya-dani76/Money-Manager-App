import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:money_manager_ap/Tabs/Controllers.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/AppBar.dart';
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
    return Consumer2<TransactionProvider , ThemeSetter>(
      builder: (context, transactionProvider , themeSetter , child) {
        return Column(
          children: [
            SolidAppBar(
              title: Text(
                'Money Manager',
                textScaleFactor: 1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(icon: Icon(FontAwesomeIcons.moon), onPressed: ()=>themeSetter.toggleTheme(),)
              ],
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                // ignore: missing_return
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                },
                child: CustomScrollView(
                  controller: listController,
                  slivers: [
                    SliverList(
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) {
                          return OneDayTransaction(
                            day: transactionProvider
                                .transactionsAllDates[index].day,
                            month: transactionProvider
                                .transactionsAllDates[index].month,
                            year: transactionProvider
                                .transactionsAllDates[index].year,
                            oneDayTransactions:
                                transactionProvider.getOneDayTransactions(
                                    transactionProvider
                                        .transactionsAllDates[index].day,
                                    transactionProvider
                                        .transactionsAllDates[index].month,
                                    transactionProvider
                                        .transactionsAllDates[index].year),
                          );
                        },
                        childCount:
                            transactionProvider.transactionsAllDates.length,
                      ),
                    ),
                    SliverList(
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) {
                          return Container(
                            height: 70,
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
