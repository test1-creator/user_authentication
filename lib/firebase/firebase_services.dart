import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {

  static Future<void> addUser(String uid, String name, int mobile, String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add({
      'uid': uid,
      'name': name,
      'mobile': mobile,
      'email': email,
    });
  }
}