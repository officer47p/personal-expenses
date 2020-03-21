import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
          // primaryColor: Colors.purple,
          // accentColor: Colors.amber,
          primarySwatch: Colors.purple,
          fontFamily: "Quicksand",
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            button: TextStyle(
              color: Colors.white,
            ),
          ),
          appBarTheme: ThemeData.light().appBarTheme.copyWith(
                textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
              ),
          floatingActionButtonTheme:
              ThemeData.light().floatingActionButtonTheme.copyWith(
                    backgroundColor: Colors.amber,
                  )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shoes",
    //   amount: 69.99,
    //   date: DateTime.now().subtract(Duration(days: 4)),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Weekly Groceries",
    //   amount: 16.53,
    //   date: DateTime.now().subtract(Duration(days: 6)),
    // ),
  ];
  bool showChart = false;

  void addNewTransaction(String title, double amount, DateTime chosenDate) {
    Transaction newTX = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      transactions.add(newTX);
    });
  }

  void startAddNewTransaction(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return NewTransaction(addNewTransaction);
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Transaction> get latestTransactions {
    return transactions.where((transaction) {
      // print(DateTime.now().difference(transaction.date).inDays);
      return DateTime.now().difference(transaction.date).inDays < 7;
    }).toList();
  }

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final inLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: inLandscape
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     child: Text("Charts"),
            //     elevation: 2,
            //     color: Colors.blue,
            //   ),
            // ),
            if (inLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Show Chart"),
                    Switch(
                        value: showChart,
                        onChanged: (val) {
                          setState(() {
                            showChart = val;
                          });
                        }),
                  ],
                ),
              ),
            if (!inLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(
                  latestTransactions,
                ),
              ),
            if (!inLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(
                  transactions,
                  deleteTransaction,
                ),
              ),
            if (inLandscape)
              showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.8,
                      child: Chart(
                        latestTransactions,
                      ),
                    )
                  : Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.8,
                      child: TransactionList(
                        transactions,
                        deleteTransaction,
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
