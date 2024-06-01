import 'package:firebase_auth/firebase_auth.dart';
import 'package:thesimpsons/model/user_model.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  //Create User
  Future<UserModel?> signUpUser(String email, String password) async {
    try{
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim());

      final User? firebaseUser = userCredential.user;
      if(firebaseUser != null){
        return UserModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            displayName: firebaseUser.displayName ?? "");
      }
    } on FirebaseAuthException catch (e){
      print(e.toString());
    }
    return null;
  }

  //Signin User

  Future<UserModel?> signInUser(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim());
      final User? firebaseUser = userCredential.user;
      if(firebaseUser != null) {
        return UserModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            displayName: firebaseUser.displayName ?? "");
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  //Sign out User

  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser != null){
      await FirebaseAuth.instance.signOut();
    }
  }


}