import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  // Getters are the properties that are calculated dynamically
  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(Duration(days: index));
        var totalSum = 0.0;
        for (var i = 0; i < recentTransaction.length; i++) {
          if (recentTransaction[i].date.day == weekday.day &&
              recentTransaction[i].date.month == weekday.month &&
              recentTransaction[i].date.year == weekday.year) {
            totalSum += recentTransaction[i].amount;
          }
        }
        // print(DateFormat.E().format(weekday));
        // print(totalSum);
        return {
          'day': DateFormat.E().format(weekday),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValue.fold(
      0.0,
      (sum, item) {
        sum += (item['amount'] as double);
        return sum;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValue);
    return Card(
      elevation: 12,
      shadowColor: Colors.grey,
      margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 17),
      child: Column(
        children: [
          Container(margin: EdgeInsets.only(top: 15),child: Text("Total spent in past 7 days \$ ${totalSpending.toStringAsFixed(2)}"),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: groupedTransactionValue.map(
                (data) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: data['day'].toString(),
                      spendingAmount: data['amount'] as double,
                      spendingPctageOfTotal: (totalSpending!=0) ? ((data['amount'] as double) / totalSpending) : 0,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
