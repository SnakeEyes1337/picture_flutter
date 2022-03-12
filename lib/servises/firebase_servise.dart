
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:picture_flutter/servises/firestore_servises.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class FirebaseServises{
  var _auth = FirebaseAuth.instance;

  Future<void> firebaseSignIn({required String email, required String password})  async {
      try{
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        Fluttertoast.showToast(msg: "SignIn Succesfull");
      } on FirebaseAuthException catch(e){
        Fluttertoast.showToast(msg: e.toString());
      }
  }

  Future<void> firebaseSignUp({required MyUser user, required String password}) async{
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: user.email.toString(),
            password: password);
        FirestoreServises().createNewUser(user);
      }on FirebaseAuthException catch(e){
        Fluttertoast.showToast(msg: e.toString());
      }

  }

  Future<void> firebaseLogout() async{
    await _auth.signOut();
    Fluttertoast.showToast(msg: "Logouted");

  }
}