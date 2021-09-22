import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:money_manager_ap/Deteminers.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/AppBar.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/BottomSheets.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/FormField.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/ImageBox/GetImageBox.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/SaveButton.dart';
import 'package:provider/provider.dart';

class GetDataPage extends StatefulWidget {
  final Transaction transaction;
  GetDataPage({Key key, this.transaction}) : super(key: key);
  @override
  _GetDataPageState createState() => _GetDataPageState();
}

class _GetDataPageState extends State<GetDataPage> {
  @override
  void initState() {
    var provider = Provider.of<Controllers>(context, listen: false);
    provider.disposeAllControllers();
    provider.setInitialValues(widget.transaction);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SolidAppBar(
          isMain: false,
          title: Consumer<Controllers>(
            builder: (BuildContext context, controllers, Widget child) =>
                DropdownButton(
              onChanged: (value) {
                controllers.setDropDownValue(value);
              },
              underline: Container(
                width: 0,
                height: 0,
              ),
              value: controllers.choosenValueForDropDown,
              items:
                  <String>['Income', 'Transfer', 'Expense'].map((String value) {
                return DropdownMenuItem(
                  child: Text(
                    value,
                    textScaleFactor: 1,
                  ),
                  value: value,
                );
              }).toList(),
            ),
          ),
          actions: [
            Container(
                child: IconButton(
              iconSize: 18,
              icon: Icon(FontAwesomeIcons.bookmark),
              onPressed: () {
                // List a = [for (int i = 0; i < 10; i++) i]; // List Comprehension
              },
            )),
          ],
        ),
        Expanded(
          child: Consumer2<ThemeSetter, Controllers>(
              builder: (context, themeSetter, controllers, child) {
            return NotificationListener<OverscrollIndicatorNotification>(
              // ignore: missing_return
              onNotification: (overScroll) {
                overScroll.disallowGlow();
              },
              child: ListView(
                padding: EdgeInsets.only(top: 0, bottom: 10),
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 25, right: 20, left: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Form(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: controllers.dateController,
                                  decoration: InputDecoration(
                                      labelText: 'Date',
                                      prefixIcon: Icon(
                                          FontAwesomeIcons.solidCalendarAlt),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onTap: () {
                                    setState(() {
                                      dateBottomSheet(
                                          context, themeSetter, controllers);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Form(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: controllers.timeController,
                                  decoration: InputDecoration(
                                      labelText: 'Time',
                                      prefixIcon: Icon(FontAwesomeIcons.clock),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onTap: () {
                                    timeBottomSheet(
                                        context, themeSetter, controllers);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  GetFormField(
                    formKey: controllers.originAccountKey,
                    prefixIcon: Icon(FontAwesomeIcons.wallet),
                    lebelText:
                        getDataFormTitle[controllers.choosenValueForDropDown]
                            [0],
                    keyboardType: 'text',
                    controller: controllers.originAccountController,
                    expands: false,
                  ),
                  GetFormField(
                    formKey: controllers.destenationAccountKey,
                    prefixIcon: Icon(FontAwesomeIcons.moneyBillAlt),
                    lebelText:
                        getDataFormTitle[controllers.choosenValueForDropDown]
                            [1],
                    keyboardType: 'text',
                    controller: controllers.destenationAccountController,
                    expands: false,
                  ),
                  GetFormField(
                    formKey: controllers.amountKey,
                    prefixIcon: Icon(FontAwesomeIcons.dollarSign),
                    lebelText: 'Amount',
                    keyboardType: 'number',
                    controller: controllers.amountController,
                    expands: false,
                  ),
                  GetFormField(
                    prefixIcon: Icon(FontAwesomeIcons.stickyNote),
                    lebelText: 'Note',
                    keyboardType: 'MultiLine',
                    controller: controllers.noteController,
                    expands: true,
                  ),
                  GetFormField(
                    prefixIcon: Icon(CupertinoIcons.book),
                    lebelText: 'Description',
                    keyboardType: 'MultiLine',
                    controller: controllers.descriptionController,
                    expands: true,
                  ),
                  GetImageBox(),
                  SaveButton(),
                ],
              ),
            );
          }),
        ),
      ],
    ));
  }
}
