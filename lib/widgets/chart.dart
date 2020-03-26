import "package:flutter/material.dart";
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  // final double totalChartHeight = 200;
  // double totalAmount = 0;
  final List<Transaction> latestTransactions;
  Chart(this.latestTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    // totalAmount = 0;
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
        // totalAmount += totalValue;
        return {
          "day": DateFormat.E().format(weekDay).substring(0, 1),
          "amount": totalValue
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(latestTransactions.length);
    return Card(
      // color: Colors.amber,
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  tx["day"],
                  tx["amount"],
                  totalSpending == 0.0
                      ? 0.0
                      : (tx["amount"] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
