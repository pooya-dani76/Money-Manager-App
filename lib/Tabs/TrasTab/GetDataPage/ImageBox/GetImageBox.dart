import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/ImageBox/ConfidenceDialog.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/ImageBox/ImageShow.dart';
import 'package:money_manager_ap/Tabs/TrasTab/GetDataPage/ImageBox/ModalBottomSheet.dart';
import 'package:provider/provider.dart';

class GetImageBox extends StatefulWidget {
  const GetImageBox({Key key}) : super(key: key);

  @override
  _GetImageBoxState createState() => _GetImageBoxState();
}

class _GetImageBoxState extends State<GetImageBox> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var provider  = Provider.of<Controllers>(context, listen: false);
    provider.images.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controllers>(
      builder: (BuildContext context, controllers, Widget child) => Container(
          padding: EdgeInsets.only(top: 15, right: 20, left: 20),
          height: 100,
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(bottom: 5)),
                      Container(
                        child: Text(
                          'Tap To Add Image',
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey,
                  ),
                ),
                onTap: () {
                  addImageBottomSheet(context);
                },
              ),
              Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                // ignore: missing_return
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                },
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controllers.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: FileImage(controllers.images[index]),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 5,
                          child: GestureDetector(
                            onTap: () async{
                              await deleteConfidenceBottomSheet(context , index);
                            },
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              child: Icon(
                                Icons.close,
                                size: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cntx) => ImageShow(
                                      image: controllers.images[index],
                                    )));
                      },
                    );
                  },
                ),
              )),
            ],
          )),
    );
  }
}
