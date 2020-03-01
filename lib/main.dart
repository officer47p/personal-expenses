import 'package:flutter/material.dart';
import './widgets/user_transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
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
  bool showAddNewTransaction = false;
  void newTransactionToggle() {
    setState(() {
      showAddNewTransaction = !showAddNewTransaction;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: newTransactionToggle),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: newTransactionToggle,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("Charts"),
                elevation: 2,
                color: Colors.blue,
              ),
            ),
            UserTransactions(showAddNewTransaction),
          ],
        ),
      ),
    );
  }
}
