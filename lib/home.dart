import 'package:expense_manager_app/model/transaction.dart';
import 'package:expense_manager_app/widgets/chart.dart';
import 'package:expense_manager_app/widgets/new_transaction.dart';
import 'package:expense_manager_app/widgets/transaction_list.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

 

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction>? _userTransactions = [
    // Transaction('01', 'New Shoes', 69.99, DateTime.now()),
    // Transaction('02', 'Weekly Groceries', 69.99, DateTime.now())
  ];
  List<Transaction>? get _recentTransactions {
    return _userTransactions!.where((tx) {
      // assert(tx != null);
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  } 

  dynamic _addNewTransaction(String txTitle, double txAmount, DateTime? chosenDate) {
    final newTx = Transaction(
        DateTime.now().toString(), txTitle, txAmount, chosenDate!);
    setState(() {
      _userTransactions!.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: null,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }
 _deleteTransaction(String id){
  setState(() {
    _userTransactions!.removeWhere((tx) => tx.id == id);
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Manager"),
        actions: [
          IconButton(
              onPressed: () => startAddNewTransaction(context),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(recentTransactions: _recentTransactions!),
            TransactionList(transactions: _userTransactions!, deleteTx: _deleteTransaction)
        
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
