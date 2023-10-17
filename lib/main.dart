import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transactions.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'models/transaction.dart';
import 'utils/app_layout.dart';
import './widgets/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
        hintColor: Colors.amber,
        // accentColor: Colors.amber,
        // highlightColor: Colors.amber,
        // focusColor: Colors.amber,
        // indicatorColor: Colors.amber,
        fontFamily: 'NotoSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              // button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Color(0xffF5D2F4),
          ),
          // textTheme: TextTheme(
          //   titleMedium: TextStyle(
          //     fontFamily: 'Montserrat',
          //     fontSize: 19,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // textTheme: ThemeData.light().textTheme.copyWith(
          //       titleMedium: TextStyle(
          //         fontFamily: 'Montserrat',
          //         fontSize: 19,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ), // textTheme
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Expense Manager",
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  final List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addUserTransaction(String txTitle, num txAmount, DateTime dtm) {
    final NewTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: dtm,
    );
    setState(() {
      _userTransaction.add(NewTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addUserTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  bool _showchart = true;

  void _deleteTranx(String id) {
    setState(() {
      _userTransaction.removeWhere((element) {
        return (element.id == id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.purple,
      //   // shape: RoundedRectangleBorder(
      //   //   borderRadius: BorderRadius.circular(30),
      //   // ),
      //   // toolbarHeight: 30,
      //   elevation: 12,
      //   // centerTitle: true,
      //   shadowColor: Colors.grey,
      //   title: Text(
      //     "Expense Manager",
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         _startAddNewTransaction(context);
      //       },
      //       icon: Icon(
      //         Icons.add,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 10,
              shadowColor: Colors.grey,
              margin: EdgeInsets.only(top: 25, right: 3, left: 3, bottom: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                    ),
                    Text(
                      "Expense Manager",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                        // color: Colors.white,
                        // fontSize: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _startAddNewTransaction(context);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show Chart"),
                    Switch(value: _showchart, onChanged: (_){
                      setState(() {
                        _showchart = ! _showchart;
                      });
                    })
                  ],
                ),
                if(_showchart == true) Chart(_recentTransactions) ,
                TransactionList(_userTransaction, _deleteTranx, isLandscape),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

// AppBar(
//
// title: const Text("Flutter App"),
// centerTitle: true,
// elevation: 8,
// shadowColor: Colors.grey,
// backgroundColor: Colors.purple,
// foregroundColor: Color(0xFFE3C4E8),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.only(
// bottomRight: Radius.circular(20),
// bottomLeft: Radius.circular(20),
// ),
// ),
// ),

// Container(
// padding: EdgeInsets.all(5),
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// // color: Colors.lightBlueAccent,
// ),
// child: Icon(
// Icons.add,
// color: Colors.white,
// size: 30,
// ),
// ),

class MyStatelessWidget extends StatelessWidget {
  final Function _addUserTranx;
  final textField = TextEditingController();
  final amountField = TextEditingController();
  MyStatelessWidget(this._addUserTranx);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Card(
              child: Column(
                children: [
                  TextField(
                    controller: textField,
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: TextStyle(color: Colors.purple),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.purple,
                        width: 1.3,
                      )),
                    ),
                  )
                ],
              ),
            );
            // return NewTransaction(_addUserTranx);
          },
        );
      },
    );
  }
}
