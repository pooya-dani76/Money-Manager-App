import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:money_manager_ap/DataBase/providerModel.dart';
import 'package:money_manager_ap/Tabs/TrasTab/DailyPage.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/GetDataPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class NavBarController extends StatefulWidget {
  const NavBarController({Key key}) : super(key: key);

  @override
  _NavBarControllerState createState() => _NavBarControllerState();
}

class _NavBarControllerState extends State<NavBarController> {
  int index;
  DateTime now;
  @override
  void initState() {
    index = 0;
    super.initState();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GetDataPage(
                        transaction: Transaction(
                            day: now.day,
                            month: now.month,
                            year: now.year,
                            hour: now.hour,
                            minute: now.minute),
                      )));
        },
        // ()=>incrementCounter(provider),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        height: 55,
        child: GNav(
          activeColor: Colors.blue,
          onTabChange: (i) {
            setState(() {
              index = i;
            });
          },
          padding: EdgeInsets.all(18),
          gap: 5,
          tabs: [
            GButton(
              icon: FontAwesomeIcons.book,
              text: 'Trans.',
              iconSize: 20,
            ),
            GButton(
              icon: FontAwesomeIcons.chartBar,
              text: 'Stats',
            ),
            GButton(
              icon: FontAwesomeIcons.database,
              text: 'Accounts',
            ),
            GButton(
              icon: FontAwesomeIcons.cog,
              text: 'Setting',
            ),
          ],
        ),
      ),
      body: navBarBody(index),
    );
  }
}

// ignore: missing_return
Widget navBarBody(int index) {
  switch (index) {
    case 0:
      return DailyPage();
    case 1:
      return Container();
    case 2:
      return Container();
    case 3:
      return Container();
  }
}

void incrementCounter(TransactionProvider provider) async {
  var insertor;
  checkTableExist();
  try {
    insertor = await insertTranscation(Transaction(
        transactionId: 1,
        note: 'for Transport from home to work',
        price: 85692100,
        destenationAccount: 'Transportation',
        description: 'from home to work',
        originAccount: 'Cash',
        year: 2021,
        month: 9,
        day: 22,
        hour: 17,
        minute: 30,
        transactionType: 'Expense'));
  } catch (e) {
    print('Error3: $e');
  }

  print(insertor);
  provider.loadInfo();
}
