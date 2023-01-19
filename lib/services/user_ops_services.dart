import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserOpsServices {
  final FirebaseFirestore firebaseFirestoreInstance;
  UserOpsServices({
    required this.firebaseFirestoreInstance,
  });
  final String _userSpecificCollectionRefPath = 'users/';

  Future<void> initUserFriend(
      {required String displayName, required String email}) async {
    Object updateData = {
      "friends": ["self"],
    };
    try {
      CollectionReference userDetailsCollectionReference =
          firebaseFirestoreInstance.collection(_userSpecificCollectionRefPath);
      await userDetailsCollectionReference
          .doc(email.split('@')[0])
          .set(updateData);
    } on FirebaseException catch (fe) {
      if (kDebugMode) {
        print(fe);
      }
    }
  }
}
