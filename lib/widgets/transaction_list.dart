import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transactions yet...",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, i) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                          child:
                              Text("\$${transactions[i].amount.toStringAsFixed(
                                    2,
                                  )}"),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[i].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[i].date),
                    ),
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
                // return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: 15,
                //         ),
                //         padding: EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Colors.purple,
                //             width: 2,
                //           ),
                //           borderRadius: BorderRadius.all(Radius.circular(25)),
                //         ),
                //         child: Text(
                //           "\$${transactions[i].amount.toStringAsFixed(2)}",
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Colors.purple,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             transactions[i].title,
                //             style: Theme.of(context).textTheme.title,
                //           ),
                //           Text(
                //             DateFormat.yMMMMd().format(transactions[i].date),
                //             style: TextStyle(
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
