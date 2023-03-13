import 'package:flutter/material.dart';
import 'transaction.dart';
import 'transaction_list.dart';
import 'new_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'Sepatu Baru', amount: 350000, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Makan Siang', amount: 38000, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Makan Malam', amount: 40000, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'Jajan Sore', amount: 10000, date: DateTime.now()),
    Transaction(id: 't5', title: 'Buah', amount: 8000, date: DateTime.now()),
    Transaction(id: 't6', title: 'Snack', amount: 5000, date: DateTime.now()),
    Transaction(
        id: 't7', title: 'Tahu Goreng', amount: 3000, date: DateTime.now()),
    Transaction(
        id: 't8', title: 'Pisang Goreng', amount: 3000, date: DateTime.now()),
    Transaction(
        id: 't9', title: 'Es cream', amount: 7000, date: DateTime.now()),
    Transaction(
        id: 't10', title: 'Teh Botol', amount: 3500, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: txDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showInputSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(title: const Center(child: Text('Expense App')));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
              height: mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top * 0.4,
              child: TransactionList(_userTransactions, _deleteTransaction))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showInputSheet(context),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
