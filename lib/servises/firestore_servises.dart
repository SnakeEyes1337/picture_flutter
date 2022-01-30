import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class FirestoreServises{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future  getCurrentUser() async {
    MyUser user  = await  _firestore.collection("users")
        .doc("userId")
        .get().then((value) => MyUser.fromMap(value.data()));
    return user;
  }
}