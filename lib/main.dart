import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/Providers.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:money_manager_ap/Tabs/NavBarController.dart';
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
    createTable();
    // checkTableExist();
    await dtb.countTable();
  } catch (e) {
    print('ErrorS1: $e');
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TransactionProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => Controllers(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ThemeSetter(),
        child: Consumer<ThemeSetter>(builder: (context, themeSetter, child) {
          themeSetter.loadTheme();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeSetter.darkMode == true ? ThemeMode.dark : ThemeMode.light,
            home: NavBarController(),
          );
        }));
  }
}
