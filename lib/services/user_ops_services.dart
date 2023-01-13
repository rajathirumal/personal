import 'package:cloud_firestore/cloud_firestore.dart';

class UserOpsServices {
  final FirebaseFirestore firebaseFirestore;
  UserOpsServices({
    required this.firebaseFirestore,
  });
  final String _userSpecificCollectionRefPath = 'users/';

  Future<void> initUserFriend(
      {required String displayName, required String email}) async {
    Object updateData = {
      "friends": ["self"],
    };
    try {
      CollectionReference userDetailsCollectionReference =
          firebaseFirestore.collection(_userSpecificCollectionRefPath);
      await userDetailsCollectionReference
          .doc(email.split('@')[0])
          .set(updateData);
    } on FirebaseException catch (fe) {
      print(fe);
    }
  }

  
}
