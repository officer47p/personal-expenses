import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: "Quicksand",
        textTheme: TextTheme(
          title: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold,
              fontSize: 18),
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
      ),
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
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 69.99,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
  ];

  void addNewTransaction(String title, double amount) {
    Transaction newTX = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      transactions.add(newTX);
    });
  }

  void startAddNewTransaction(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return NewTransaction(addNewTransaction);
      },
    );
  }

  List<Transaction> get latestTransactions {
    return transactions.where((transaction) {
      // print(DateTime.now().difference(transaction.date).inDays);
      return DateTime.now().difference(transaction.date).inDays < 7;
    }).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            Chart(latestTransactions),
            TransactionList(transactions),
          ],
        ),
      ),
    );
  }
}
