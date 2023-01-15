import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal/pages/expense/add_expense.dart';
import 'package:personal/services/expense_service.dart';
import 'package:provider/provider.dart';

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
      body: StreamBuilder(
        stream: context
            .read<FirebaseFirestore>()
            .collection('/casualExpenses')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Fuel home"));
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Text(document['itemName'].toString());
            }).toList(),
          );
        },
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
