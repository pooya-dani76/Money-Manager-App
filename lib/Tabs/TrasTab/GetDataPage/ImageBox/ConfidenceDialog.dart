import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/ImageBox/ConfidenceDialogButton.dart';
import 'package:provider/provider.dart';

Future<Widget> deleteConfidenceBottomSheet(BuildContext context, int index) async {
  return await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) => Consumer<Controllers>(
            builder: (BuildContext context, controllers, Widget child) =>
                Container(
              height: 130,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Are You Sure To Delete This Picture?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ConfidenceDialogButton(
                            text: 'Yes',
                            color: Colors.green,
                            onTap: () {
                              controllers.removeImageIndex(index);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ConfidenceDialogButton(
                            text: 'No',
                            color: Colors.red,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
}
