import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:money_manager_ap/DataBase/providerModel.dart';

void dateBottomSheet1(BuildContext context, ThemeSetter themeSetter) {
  showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            height: 250,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Text(
                          'Done',
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    backgroundColor: themeSetter.darkMode == true
                        ? Colors.black
                        : Colors.white,
                    onDateTimeChanged: (DateTime value) {},
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                  ),
                )
              ],
            ));
      });
}

void dateBottomSheet2(
    BuildContext context, ThemeSetter themeSetter, Controllers controllers) {
  DatePicker.showDatePicker(context,
      theme: DatePickerTheme(
        cancelStyle: TextStyle(color: Colors.red),
        itemStyle: TextStyle(
          color: themeSetter.darkMode == true ? Colors.white : Colors.black,
        ),
        backgroundColor:
            themeSetter.darkMode == true ? Colors.black : Colors.white,
      ),
      currentTime: DateTime.now(), onConfirm: (date) {
    controllers.setDate(date);
  });
}

void timeBottomSheet(
    BuildContext context, ThemeSetter themeSetter, Controllers controllers) {
  DatePicker.showTimePicker(context,
  showSecondsColumn: false,
      theme: DatePickerTheme(
        cancelStyle: TextStyle(color: Colors.red),
        itemStyle: TextStyle(
          color: themeSetter.darkMode == true ? Colors.white : Colors.black,
        ),
        backgroundColor:
            themeSetter.darkMode == true ? Colors.black : Colors.white,
      ),
      currentTime: DateTime.now(), onConfirm: (date) {
    controllers.setTime(date);
  });
}