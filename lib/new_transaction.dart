import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? _date;

  void submitData() {
    if (amountController.text.isEmpty) return;
    final enteredAmount = double.parse(amountController.text);
    final enteredTitle = titleController.text;

    if (enteredTitle.isEmpty || !(enteredAmount > 0 || _date != null)) return;
    widget.addTx(
        txTitle: enteredTitle, txAmount: enteredAmount, pickedDate: _date);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2022, 12))
        .then((acceptedDate) {
      if (acceptedDate == null) return;
      setState(() {
        _date = acceptedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                left: 10.0,
                top: 10.0,
                right: 10.0,
                bottom: 10.0 + (MediaQuery.of(context).viewInsets.bottom)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  //cursorColor: Colors.orangeAccent,
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  //cursorColor: Colors.orangeAccent,
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_date == null
                          ? "No date chosen yet"
                          : "chosen Date: ${DateFormat.yMd().format(_date!)}"),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            "choose date",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  onPressed: () {
                    submitData();
                  },
                  child: const Text("Add Transaction",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          )),
    );
  }
}
