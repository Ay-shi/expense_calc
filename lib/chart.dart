import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import './models/transaction.dart';
import './chat_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  //const ({ Key? key }) : super(key: key);
  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      var totalAmount = 0.0;
      final weekday = DateTime.now().subtract(Duration(days: index));

      for (int i = 0; i < recentTransactions.length; i++) {
        if (weekday.day == recentTransactions[i].date.day &&
            weekday.month == recentTransactions[i].date.month &&
            weekday.year == recentTransactions[i].date.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      // print(totalAmount);
      //print(DateFormat.E().format(weekday));
      return {"day": DateFormat.E().format(weekday), "amount": totalAmount};
    }).reversed.toList();
  }

  double get total {
    return _groupedTransactionValues.fold(0.0, (sum, el) {
      return sum + (el['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(_groupedTransactionValues);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionValues.map((value) {
            return Bar(
              value['day'] as String,
              value['amount'] as double,
              total == 0 ? 0 : (((value['amount']) as double) / total),
              //(((value['amount']) as double) / total),
            );
          }).toList()),
    );
  }
}
