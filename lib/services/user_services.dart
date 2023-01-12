import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  final FirebaseFirestore firebaseFirestore;
  UserServices({
    required this.firebaseFirestore,
  });

  Future<void> setUserDeatils(
      {required String displayName, required String email}) async {
    Object updateData = {
      "email": email,
      "displayName": displayName,
      "friends": ["self"],
    };
    try {
      String userSpecificCollectionRefPath = 'users/';

      CollectionReference userDetailsCollectionReference =
          firebaseFirestore.collection(userSpecificCollectionRefPath);

      await userDetailsCollectionReference
          .doc(email.split('@')[0])
          .set(updateData);
    } on FirebaseException catch (fe) {
      print(fe);
    }
  }
}
