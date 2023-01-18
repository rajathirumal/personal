import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:personal/pages/expense/add_expense.dart';

class OOPSWidget extends StatelessWidget {
  const OOPSWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No data to display ..."),
          TextButton(
              onPressed: () {Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpense(),
            ),
          );},
              child: const Text(
                "Try adding new data",
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }
}
