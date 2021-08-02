import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/providerModel.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:money_manager_ap/Tabs/TrasTab/DailyPage.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
  } catch (e) {
    print('ErrorS: $e');
  }

  /// Initialize sq-lite
  try {
    final dtb = SqliteDB();
    checkTableExist();
    await dtb.countTable();
  } catch (e) {
    print('ErrorS1: $e');
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TransactionProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DailyPage(),
    );
  }
}