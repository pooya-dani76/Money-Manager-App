import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:provider/provider.dart';

Future<Widget> addImageBottomSheet(BuildContext context) async {
  return await showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (context) {
        return Consumer<Controllers>(
          builder: (BuildContext context, controllers, Widget child) =>
              Container(
            height: 171,
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      ' Add Photo ',
                      textScaleFactor: 1,
                    ),
                  ),
                ),
                Card(
                  child: Divider(
                    endIndent: 20,
                    indent: 20,
                    height: 1,
                  ),
                  margin: EdgeInsets.all(0),
                ),
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        // ignore: missing_return
                        (overScroll) {
                      overScroll.disallowGlow();
                    },
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          margin: EdgeInsets.all(0),
                          child: Container(
                            height: 60,
                            child: TextButton(
                                child: Text(
                                  ' Camera ',
                                  textScaleFactor: 1,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  var pickedImage = await controllers.picker
                                      .pickImage(source: ImageSource.camera);
                                  if (pickedImage != null)
                                    controllers
                                        .addImage(File(pickedImage.path));
                                  else
                                    print('Error while Picking Image!');
                                }),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          margin: EdgeInsets.all(0),
                          child: Container(
                            height: 60,
                            child: TextButton(
                                child: Text(
                                  ' Gallery ',
                                  textScaleFactor: 1,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  var pickedImage = await controllers.picker
                                      .pickImage(source: ImageSource.gallery);
                                  if (pickedImage != null)
                                    controllers
                                        .addImage(File(pickedImage.path));
                                  else
                                    print('Error while Picking Image!');
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
