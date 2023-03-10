import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:personal/models/add_expense_model.dart';

class ExpenseService {
  FirebaseFirestore firestoreInstanse = FirebaseFirestore.instance;
  Future<void> addAnExpense({required SingleExpense newExpense}) async {
    firestoreInstanse
        .collection('/casualExpenses')
        .doc(newExpense.expenseID)
        .set(newExpense.toMap());
  }

  Stream<void> getUsersCassualExpenses1() {
    return firestoreInstanse
        .collection('/casualExpenses')
        .snapshots()
        .map((snapshot) {
      if (kDebugMode) {
        print(">.${snapshot.docs}");
      }
      snapshot.docs.map(
        (eachDoc) {
          if (kDebugMode) {
            print(">..${eachDoc.data}");
          }
        },
      );
    });
  }

  Stream<List<SingleExpense>> getUsersCassualExpenses() {

    return firestoreInstanse
        .collection("/casualExpenses")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => SingleExpense.fromMap(document.data()))
            .toList());
  }
}
