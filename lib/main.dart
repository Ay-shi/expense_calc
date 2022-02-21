import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import './list_transaction.dart';
// import 'package:expense_calc/new_transaction.dart';
import './new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
// import 'package:intl/intl.dart';
//import './user_transaction.dart';
import './chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: const Color(0xFFE06D60),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0x1A5C4430),
              titleTextStyle: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: const TextStyle(color: Colors.white)),
          fontFamily: "Quicksand"),
      // const TextTheme(
      //     headline6: TextStyle(
      //         fontFamily: "QuickSand",
      //         fontWeight: FontWeight.bold,
      //         fontSize: 18)),
      // fontFamily: "Quicksand"),
      // theme: ThemeData(
      //     scaffoldBackgroundColor: const Color(0xFFE06D60),
      //     primaryColor: const Color(0xFFF7864D),
      //     primaryColorDark: const Color(0xFF9E5531),
      //     primaryColorLight: const Color(0xFFE08B60),
      //     //       backgroundColor: const Color(0xFFE06D60),
      //     primaryColorBrightness: Brightness.dark,
      //     //appBarTheme: const AppBarTheme(backgroundColor: Color(0x1A5C4430))
      //     ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  //   Transaction(
  //       id: "t1", title: "New Shoes", amount: 20000, date: DateTime.now()),
  //   Transaction(
  //       id: "t2", title: "New laptop", amount: 200000, date: DateTime.now())
  // ];
  void _addNewtx(
      {required String txTitle,
      required double txAmount,
      required DateTime pickedDate}) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: pickedDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startToAddNewTrans(BuildContext ctx) {
    //print("hi");
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewtx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData _mediaQuery, AppBar appBar, Widget _listTx) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Show chart",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Switch(
              value: _switchChart,
              onChanged: (val) {
                setState(() {
                  _switchChart = val;
                });
              }),
        ],
      ),
      (_switchChart == true)
          ? Container(
              height: (_mediaQuery.size.height -
                      appBar.preferredSize.height -
                      _mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          :
          // NewTransaction(_addNewtx),
          _listTx,
    ];
  }

  List<Widget> _buildPotraitContent(
      MediaQueryData _mediaQuery, AppBar appBar, Widget _listTx) {
    return [
      Container(
          height: (_mediaQuery.size.height -
                  appBar.preferredSize.height -
                  _mediaQuery.padding.top) *
              0.25,
          child: Chart(_recentTransactions)),
      _listTx
    ];
  }

  var _switchChart = false;

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _islandscape = _mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Expenses App",
          style: TextStyle(color: Theme.of(context).primaryColor)),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              _startToAddNewTrans(context);
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
            ))
      ],
    );
    final _listTx = Container(
        height: (_mediaQuery.size.height -
                appBar.preferredSize.height -
                _mediaQuery.padding.top) *
            0.75,
        child: TransactionList(_userTransactions, _removeTransaction));
    return Scaffold(
      floatingActionButton: Builder(
          builder: (cx) => FloatingActionButton(
                //backgroundColor: Color(0x1A5C4430),
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Theme.of(context).primaryColor,
                      context: context,
                      builder: (bCtx) {
                        return Container(child: NewTransaction(_addNewtx));
                      });
                },
                child: Icon(Icons.add, color: Colors.white),
              )),
      appBar: appBar,
      body:
          // Container(
          //   width: double.infinity,
          //   color: Colors.orangeAccent,
          SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_islandscape)
                ..._buildLandscapeContent(_mediaQuery, appBar, _listTx),
              if (!_islandscape)
                ..._buildPotraitContent(_mediaQuery, appBar, _listTx)
            ]),
      ),
    );
  }
}
