import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:money_manager_ap/Deteminers.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/GetDataPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBarController extends StatefulWidget {
  const NavBarController({Key key}) : super(key: key);

  @override
  _NavBarControllerState createState() => _NavBarControllerState();
}

class _NavBarControllerState extends State<NavBarController> {
  int index;
  @override
  void initState() {
    index = 0;
    super.initState();
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
                            day: DateTime.now().day,
                            month: DateTime.now().month,
                            year: DateTime.now().year,
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute),
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
      body: transTabPages[index],
    );
  }
}

void incrementCounter(TransactionProvider provider) async {
  var insertor;
  checkTableExist();
  try {
    insertor = await insertTranscation(Transaction(
        transactionId: 1,
        note: 'for Transport from home to work',
        price: 8569000,
        destenationAccount: 'Transportation',
        description: 'from home to work',
        originAccount: 'Cash',
        year: 2021,
        month: 9,
        day: 23,
        hour: 17,
        minute: 30,
        transactionType: 'Expense'));
  } catch (e) {
    print('Error3: $e');
  }

  print(insertor);
  provider.loadInfo();
}
