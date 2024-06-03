import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thesimpsons/model/user_model.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Create User
  Future<UserModel?> signUpUser(String email, String password, String name, String surname) async {
    try{
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim());

      final User? firebaseUser = userCredential.user;
      if(firebaseUser != null){
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'email': email,
          'name': name,
          'surname': surname,
          'password': password

        });
        return UserModel(
            id: firebaseUser.uid,
            email: email,
            name: name,
            surname: surname);
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
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        return UserModel(
            id: firebaseUser.uid,
            name: data['name'],
            surname: data['surname'],
            email: data['email']);
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

  //Forgot Password

  void passwordResetWithMail ({required String mail}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: mail);
    }catch (e) {
      print(e.toString());
    }
  }

}