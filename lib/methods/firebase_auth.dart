import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> createUser1({
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'email': email,
        'phone': phone,
        'firstName': firstName,
        'lastName': lastName,
      });
      await FirebaseFirestore.instance
          .collection('vars')
          .doc('vars')
          .update({'userCount': FieldValue.increment(1)});
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Муу нууц үг.";
      } else if (e.code == 'email-already-in-use') {
        return "Бүртгэлтэй имэйл.";
      }
    } catch (e) {
      return "!";
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Бүртгэлгүй имэйл.';
      } else if (e.code == 'wrong-password') {
        return 'Нууц үг буруу.';
      }
    }

    // try {
    //   UserCredential credential = await _firebaseAuth
    //       .createUserWithEmailAndPassword(email: email, password: password);
    //   return credential.user!.uid;
    // } catch (e) {
    //   return 'error';
    // }
  }

  Future<bool> logout() async {
    try {
      _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
