import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal/models/add_expense_model.dart';

class ExpenseService {
  addAnExpense(
      {required FirebaseFirestore firestoreInstanse,
      required SingleExpense newExpense,
      required String userEmail}) {
    String docID = "${userEmail.split('@')[0]}:${newExpense.expenseID}";
    firestoreInstanse
        .collection('/casualExpenses')
        .doc(docID)
        .set(newExpense.toMap());
  }

  
}
