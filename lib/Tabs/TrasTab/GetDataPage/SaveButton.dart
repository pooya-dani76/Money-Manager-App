import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({Key key}) : super(key: key);

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<Controllers, ThemeSetter, TransactionProvider>(
      builder: (BuildContext context, controllers, themeSetter,
              transactionProvider, Widget child) =>
          Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 25, right: 20, left: 20, bottom: 30),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
            fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            side: BorderSide(
                color: themeSetter.darkMode == true
                    ? Color.fromARGB(255, 97, 169, 255)
                    : Colors.indigo,
                width: 3.0),
          ),
          onPressed: () {
            if (controllers.originAccountKey.currentState.validate() &&
                controllers.destenationAccountKey.currentState.validate() &&
                controllers.amountKey.currentState.validate()) {
              print(controllers.validateFields());
              controllers.addCurrentTransactionToDataBase();
              transactionProvider.loadInfo();
              transactionProvider.refresh();
              Navigator.pop(context);
            }
          },
          child: Text(
            'Save',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: themeSetter.darkMode == true
                  ? Color.fromARGB(255, 97, 169, 255)
                  : Colors.indigo,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
