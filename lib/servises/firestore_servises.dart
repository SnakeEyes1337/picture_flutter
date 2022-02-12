import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class FirestoreServises{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser  = FirebaseAuth.instance.currentUser;
  Future  getCurrentUser() async {
    MyUser user  = await  _firestore.collection("users")
        .doc(_currentUser!.uid)
        .get().then((value) => MyUser.fromMap(value.data()));
    return user;
  }
  Future<void> createNewUser(MyUser user) async{
    await _firestore.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toMap());
    Fluttertoast.showToast(msg: "New account added");
  }
}