import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';

void dateBottomSheet(
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
