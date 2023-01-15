import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal/models/add_expense_model.dart';

class ExpenseService {
  FirebaseFirestore firestoreInstanse = FirebaseFirestore.instance;
  Future<void> addAnExpense({required SingleExpense newExpense}) async {
    firestoreInstanse
        .collection('/casualExpenses')
        .doc(newExpense.expenseID)
        .set(newExpense.toMap());
  }

  Stream<void> getUsersCassualExpenses() {
    return firestoreInstanse
        .collection('/casualExpenses')
        .snapshots()
        .map((snapshot) {
      print(">." + snapshot.docs.toString());
      snapshot.docs.map(
        (eachDoc) {
          print(">.." + eachDoc.data.toString());
        },
      );
    });
  }

  List<String> getExp() {
    firestoreInstanse
        .collection('/casualExpenses')
        .doc()
        .snapshots()
        .map((event) => print("> ////" + event.toString()));

    return ["da", "da"];
  }
}
