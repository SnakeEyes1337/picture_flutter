
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseServises{
  var _auth = FirebaseAuth.instance;

  Future<void> firebaseSignIn({required String email, required String password, required bool validator})  async {
    if(validator){
      try{
        UserCredential userCredential =  await _auth.signInWithEmailAndPassword(email: email, password: password);
        Fluttertoast.showToast(msg: "SignIn Succesfull");
      } on FirebaseAuthException catch(e){
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  Future<void> firebaseLogout() async{
    await _auth.signOut();
    Fluttertoast.showToast(msg: "Logouted");

  }
}