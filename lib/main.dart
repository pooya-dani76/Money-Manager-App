import 'package:flutter/material.dart';
import 'package:money_manager_ap/DataBase/providerModel.dart';
import 'package:money_manager_ap/DataBase/SqliteFunction.dart';
import 'package:money_manager_ap/DataBase/Data.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: DailyPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter(TransactionProvider provider) async {
    int b;
    // ignore: unused_local_variable
    var c, a;

    try {
      final db = SqliteDB();
      b = await db.countTable();
    } catch (e) {
      print('Error1: $e');
    }

    if (b == 0) {
      try {
        c = await createTable();
      } catch (e) {
        print('Error2: $e');
      }
    }

    try {
      a = await insertTranscation(Transaction(
        transactionId: 1,
        note: 'sik',
        price: 8569,
        destenationAccount: 'got',
        extraNote: 'Goto sikim',
        originAccount: 'sik',
        year: 2020,
        month: 9 ,
        day: 20 ,
        hour: 17 ,
        minute: 30
      ));
    } catch (e) {
      print('Error3: $e');
    }

    print(a);
    provider.loadInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transaction, child) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(transaction.transcations[index].year.toString()),
              );
            },
            itemCount: transaction.transcations.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(provider),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
