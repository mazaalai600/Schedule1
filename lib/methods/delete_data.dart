import 'package:cloud_firestore/cloud_firestore.dart';
import '../../helper/helper_constant.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(usersCollection);

  Future deleteuser() {
    return userCollection.doc(uid).delete();
  }
}
