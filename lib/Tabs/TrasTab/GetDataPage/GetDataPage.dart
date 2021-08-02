import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/AppBar.dart';

class GetDataPage extends StatefulWidget {
  final Transaction transaction;
  const GetDataPage({Key key, this.transaction}) : super(key: key);
  @override
  _GetDataPageState createState() => _GetDataPageState();
}

class _GetDataPageState extends State<GetDataPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SolidAppBar(
          title: Text(
            'Income',
            textScaleFactor: 1,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
                child: IconButton(
              iconSize: 18,
              icon: Icon(FontAwesomeIcons.bookmark),
              onPressed: () {},
            )),
          ],
        ),
        Expanded(
          child: NotificationListener<OverscrollIndicatorNotification>(
            // ignore: missing_return
            onNotification: (overScroll) {
              overScroll.disallowGlow();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 25, right: 20, left: 20),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Date',
                          prefixIcon: Icon(FontAwesomeIcons.solidCalendarAlt),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 25, right: 20, left: 20),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'From',
                          prefixIcon: Icon(FontAwesomeIcons.wallet),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 25, right: 20, left: 20),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'To',
                          prefixIcon: Icon(FontAwesomeIcons.moneyBillAlt),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 25, right: 20, left: 20),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Amount',
                          prefixIcon: Icon(FontAwesomeIcons.dollarSign),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 25, right: 20, left: 20),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Note',
                          prefixIcon: Icon(FontAwesomeIcons.stickyNote),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 25, right: 20, left: 20),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Description',
                          prefixIcon: Icon(CupertinoIcons.book),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
