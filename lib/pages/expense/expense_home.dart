import 'package:flutter/material.dart';
import 'package:personal/pages/expense/add_expense.dart';

class ExpenseHome extends StatefulWidget {
  const ExpenseHome({super.key});

  @override
  State<ExpenseHome> createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Expense home"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpense(),
            ),
          );
        },
        label: const Text('Add fuel'),
      ),
    );
  }
}
