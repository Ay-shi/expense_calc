import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  //const Bar({ Key? key }) : super(key: key);
  String label;
  double spending;
  double SpendingPercent;

  Bar(this.label, this.spending, this.SpendingPercent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      // return Padding(
      //   padding: const EdgeInsets.all(6.0),
      child:
      return Column(
        children: [
          SizedBox(
              height: constraints.maxHeight * 0.15,
              child:
                  FittedBox(child: Text("\$${spending.toStringAsFixed(0)}"))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 25,
            // margin: EdgeInsets.all(6),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                    heightFactor: SpendingPercent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: Text(
              label,
              //style: TextStyle(fontSize: constraints.maxHeight * 0.15),
            ),
          ),
        ],
      );
    });
  }
}
