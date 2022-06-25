import 'package:flutter/material.dart';

import 'expense_manager_theme.dart';
import 'home.dart';

void main() {
  runApp(const ExpenseManagerApp());
}

class ExpenseManagerApp extends StatelessWidget {
  const ExpenseManagerApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
final theme = ExpenseMAnagerTheme.dark();
    return MaterialApp(
      title: "Personal Expenses",
      debugShowCheckedModeBanner: false,
      theme: theme,
      
      home: const Home(),
    );
  }
}
