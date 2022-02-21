import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/transaction.dart';

class TransactionList extends StatelessWidget {
  //const TransactionList({Key? key}) : super(key: key);
  final List<Transaction> transactions;
  Function removeTx;
  TransactionList(this.transactions, this.removeTx);

  //@override
  // final List<Transaction> _userTransactions = [
  //   Transaction(
  //       id: "t1", title: "New Shoes", amount: 20000, date: DateTime.now()),
  //   Transaction(
  //       id: "t2", title: "New laptop", amount: 200000, date: DateTime.now())
  // ];
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctnxt, constraints) {
            return Column(
              children: [
                Text("No items have been added yet :( !!",
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 20),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset("assets/images/waiting.png",
                        fit: BoxFit.cover))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (cntxt, index) {
              return Card(
                color: Colors.transparent,
                child: ListTile(
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColorLight),
                    child: FittedBox(
                        child: Text(
                            "\$${transactions[index].amount.toStringAsFixed(2)}")),
                  ),
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.headline6),
                  subtitle: Text(
                    DateFormat.yMMMMEEEEd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? TextButton.icon(
                          label: Text("Delete"),
                          icon: Icon(Icons.delete_sharp),
                          onPressed: () {
                            removeTx(transactions[index].id);
                          },
                        )
                      : IconButton(
                          focusColor: Colors.red,
                          hoverColor: Colors.red,
                          icon: Icon(
                            Icons.delete_sharp,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            removeTx(transactions[index].id);
                          },
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
    // : ListView.builder(
    //     itemBuilder: (cntxt, index) {
    //       return Card(
    //           borderOnForeground: true,
    //           child: Row(
    //             children: [
    //               Container(
    //                 child: Text(
    //                   "\$${transactions[index].amount.toStringAsFixed(2)}",
    //                   style: TextStyle(
    //                       color: Theme.of(context).primaryColor,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 18),
    //                 ),
    //                 margin: const EdgeInsets.all(5.0),
    //                 decoration: BoxDecoration(
    //                     //color: Theme.of(context).primaryColor,
    //                     border: Border.all(
    //                         color: Theme.of(context).primaryColor,
    //                         width: 2,
    //                         style: BorderStyle.solid)),
    //                 padding: const EdgeInsets.symmetric(
    //                     vertical: 5.0, horizontal: 2.0),
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(transactions[index].title,
    //                       style: Theme.of(context).textTheme.headline6),
    //                   Text(
    //                       DateFormat.yMMMMEEEEd()
    //                           .format(transactions[index].date),
    //                       style: const TextStyle(
    //                           fontStyle: FontStyle.italic,
    //                           color: Colors.grey,
    //                           fontSize: 14))
    //                 ],
    //               )
    //             ],
    //           ));
    //     },
    //     itemCount: transactions.length,
    //   ),
  }
}
