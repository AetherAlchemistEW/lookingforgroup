import 'package:firebase_auth/firebase_auth.dart';
import 'package:lookingforgroup/helper/helper_function.dart';
import 'package:lookingforgroup/services/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login

  //register
  Future registerUserWithEmailAndPassword (String fullName, String email, String password) async {
  try {
    User? user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    if(user != null){
      await DatabaseService(uid: user.uid).savingUserData(fullName, email);
      return true;
    }
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
}

  //signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserNameStatus("");
      await HelperFunctions.saveUserEmailStatus("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future signInWithEmailAndPassword (String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
      if(user != null){
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}