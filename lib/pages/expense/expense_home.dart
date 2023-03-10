import 'package:flutter/material.dart';
import 'package:personal/models/add_expense_model.dart';
import 'package:personal/pages/expense/add_expense.dart';
import 'package:personal/widgets/expense_card.dart';
import 'package:personal/widgets/oops_widget.dart';
import 'package:provider/provider.dart';

class ExpenseHome extends StatefulWidget {
  const ExpenseHome({super.key});

  @override
  State<ExpenseHome> createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  @override
  Widget build(BuildContext context) {
    final allExpenses = Provider.of<List<SingleExpense>?>(context);
    return Scaffold(
      appBar: AppBar(),
      body: (allExpenses != null)
          ? (allExpenses.isEmpty)
              // ? const Center(child: CircularProgressIndicator.adaptive())
              ? const OOPSWidget()
              : ListView.builder(
                  itemCount: allExpenses.length,
                  itemBuilder: (context, index) {
                    return ExpenseCard(
                      expense: allExpenses,
                      index: index,
                    ); //Text(allExpenses[index].count);
                  },
                )
          : const Center(child: LinearProgressIndicator()),
      // StreamBuilder(
      //   stream: context
      //       .read<FirebaseFirestore>()
      //       .collection('/casualExpenses')
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return const Center(child: Text("Fuel home"));
      //     } else if (!snapshot.hasData) {
      //       return const Center(child: CircularProgressIndicator.adaptive());
      //     }
      //     return ListView(
      //       children: snapshot.data!.docs.map((document) {
      //         return Text(document['itemName'].toString());
      //       }).toList(),
      //     );
      //   },
      // ),
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
