import "package:flutter/material.dart";
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> latestTransactions;
  Chart(this.latestTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalValue = 0.0;
        for (int i = 0; i < latestTransactions.length; i++) {
          if (latestTransactions[i].date.day == weekDay.day &&
              latestTransactions[i].date.month == weekDay.month &&
              latestTransactions[i].date.year == weekDay.year) {
            totalValue += latestTransactions[i].amount;
          }
        }
        return {"day": DateFormat.E().format(weekDay), "amount": totalValue};
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      color: Colors.amber,
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[],
      ),
    );
  }
}
