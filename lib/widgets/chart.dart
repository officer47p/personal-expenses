import "package:flutter/material.dart";
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> latestTransactions;
  double totalAmount;
  double heightOfTheChart = 1400;
  Chart(this.latestTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    totalAmount = 0;
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalValue = 0.0;
        for (int i = 0; i < latestTransactions.length; i++) {
          totalAmount += latestTransactions[i].amount;
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: groupedTransactionValues.map((dayInfo) {
            return Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
                    ),
                    height: (double.parse(dayInfo["amount"].toString()) /
                        totalAmount *
                        heightOfTheChart),
                    width: 20,
                  ),
                  Text(dayInfo["day"])
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
