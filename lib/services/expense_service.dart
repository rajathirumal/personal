import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal/models/add_expense_model.dart';

class ExpenseService {
  addAnEcpense(
      {required FirebaseFirestore firestoreInstanse,
      required SingleExpense newExpense,
      required String userEmail}) {
    print("New expense >> " + newExpense.toJson());
    CollectionReference cr = firestoreInstanse.collection('/expenses');
    DocumentReference dr = firestoreInstanse.doc('/expenses/casualExpenses');
    String docID =
        "casualExpenses:${userEmail.split('@')[0]}:${newExpense.expenseID}";
    // dr.set(newExpense.toMap());
    cr.doc(docID).set(newExpense.toMap());
  }
}
