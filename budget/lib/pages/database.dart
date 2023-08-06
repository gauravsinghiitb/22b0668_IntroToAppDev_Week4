import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String topic, double amount) async {
    await userCollection.doc(uid).collection('expenses').add({
      'topic': topic,
      'amount': amount,
    });
  }

  Stream<List<Map<String, dynamic>>> getExpensesStream() {
    return userCollection.doc(uid).collection('expenses').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
