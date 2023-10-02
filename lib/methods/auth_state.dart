import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../helper/helper_constant.dart';
import '../helper/string_ext.dart';
import '../helper/utility.dart';
import 'delete_data.dart';
import '../models/user_model.dart';


/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
class AuthState with ChangeNotifier, DiagnosticableTreeMixin {
  AuthStatus authStatus = AuthStatus.notDetermined;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late List<QueryDocumentSnapshot> notificationsListStream;
  final FirebaseFirestore kfirestore = FirebaseFirestore.instance;

  late User user;
  bool loading = false;
  int _count = 0;
  var errorMessage = '';

  late UserModel userModel;
  late UserModel userModelTemp;
  int get count => _count;
  String phoneNumberTemp = '';

  void increment() {
    _count++;
    notifyListeners();
  }

  // Fetch current user profile
  Future<User?> getCurrentUser({required BuildContext context}) async {
    try {
      loading = true;
      if (kDebugMode) {
        print("eniig hevel ${_firebaseAuth.currentUser}");
      }

      //user = _firebaseAuth.currentUser!;
      if (_firebaseAuth.currentUser!.uid != null) {
        //userId = user.uid;
        bool isProfiled =
            await getProfileUser(userProfileId: _firebaseAuth.currentUser!.uid);
        print(isProfiled);
        if (!isProfiled) {
          await Navigator.pushNamed(context, "/register");
        }
        authStatus = AuthStatus.loggedIn;
      } else {
        authStatus = AuthStatus.notLoggedIn;
      }
      loading = false;
      return _firebaseAuth.currentUser;
    } catch (error) {
      authStatus = AuthStatus.notLoggedIn;
      loading = false;
      return null;
    }
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage =
            'Е-мэйл хаяг бүртгэлгүй байна. Та бүртгүүлэх товч дарж бүртгүүлнэ үү.';
        if (kDebugMode) {
          print(errorMessage);
        }
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Нууц үг буруу байна.';
        if (kDebugMode) {
          print(errorMessage);
        }
      } else {
        errorMessage = 'Холболтын алдаа гарлаа. ${e.code}';
        if (kDebugMode) {
          print(errorMessage);
        }
      }
      return errorMessage;
    }
    authStatus = AuthStatus.loggedIn;
    return 'signed';
  }

  // Future<String> sendMessageWithPhoneNumber(
  //     {required String phoneNumber, required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   if (kDebugMode) {
  //     print(phoneNumber);
  //   }
  //   phoneNumberTemp = phoneNumber;
  //   EasyLoading.show();
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: '+976 $phoneNumber',
  //     timeout: const Duration(seconds: 60),
  //     codeSent: (String verificationId, int? resendToken) async {
  //       // Update the UI - wait for the user to enter the SMS code
  //       EasyLoading.dismiss();
  //       final code = await Navigator.pushNamed(context, "/message_check");
  //       String smsCode = code.toString();
  //       // print(smsCode);
  //       if (smsCode != '' && smsCode != 'null') {
  //         EasyLoading.show();
  //         // Create a PhoneAuthCredential with the code
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //             verificationId: verificationId, smsCode: smsCode);
  //         // Sign the user in (or link) with the credential

  //         await auth
  //             .signInWithCredential(credential)
  //             .then((userCredential) async {
  //           EasyLoading.dismiss();
  //           if (userCredential.additionalUserInfo!.isNewUser) {
  //             await Navigator.pushNamed(context, "/register");
  //           } else {
  //             // ignore: use_build_context_synchronously
  //             Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(builder: (_) => const SelectAuthMethod()),
  //               (route) => false,
  //             );
  //           }
  //         }).onError((error, stackTrace) {
  //           EasyLoading.dismiss();
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) => AlertDialog(
  //               title: const Text("Алдаа."),
  //               content: const Text('Код буруу байна.'),
  //               actions: [
  //                 TextButton(
  //                   child: const Text("OK"),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               ],
  //             ),
  //           );
  //         });
  //       }
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //     verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
  //     verificationFailed: (FirebaseAuthException error) {
  //       EasyLoading.dismiss();
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) => AlertDialog(
  //           title: const Text("Алдаа."),
  //           content: const Text('Уучлаарай илгээж чадсангүй.'),
  //           actions: [
  //             TextButton(
  //               child: const Text("OK"),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //       if (kDebugMode) {
  //         print(error);
  //       }
  //     },
  //   );
  //   return errorMessage;
  // }

  Future<String> signUp(
      {required String email,
      required String password,
      required String phone,
      required String fname,
      required String lname,
      required String role}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userNew = UserModel(
        username: normaliseName(getUserName(
          id: _firebaseAuth.currentUser!.uid,
          name: fname,
        )),
        firstName: normaliseName(fname),
        lastName: normaliseName(lname),
        email: email,
        fcmToken: '',
        profileImage: '',
        phone: phone,
        userId: _firebaseAuth.currentUser!.uid,
        createdAt: DateTime.now().toUtc().toLocal().toString(),
        role: role,
      );
      userModel = userNew;
      print("newUser hevel ${userModel}");
      print("uid hevel ${_firebaseAuth.currentUser!.uid}");

      try {
        await kfirestore
            .collection(usersCollection)
            .doc(userModel.userId)
            .set(userModel.toJson());
        int userCount = 1, userCountF = 0, userCountM = 0;
        await FirebaseFirestore.instance.collection('vars').doc('vars').update({
          'userCount': FieldValue.increment(userCount),
          'userCountM': FieldValue.increment(userCountM),
          'userCountF': FieldValue.increment(userCountF),
        });
      } catch (e) {
        print("didnt work at all");
      }
      //1-eer nemegduuleh
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    authStatus = AuthStatus.loggedIn;
    return 'signedUp';
  }

  Future<void> signOut(BuildContext context) async {
    //print('duudsan');
    await FirebaseAuth.instance.signOut();
    authStatus = AuthStatus.notLoggedIn;
    Navigator.pushNamed(context, "/login");
  }

  Future<bool> getProfileUser({required String userProfileId}) async {
    var docSnapshot =
        await kfirestore.collection(usersCollection).doc(userProfileId).get();
    print(docSnapshot.exists);
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      userModel = UserModel.fromJson(data!);
      await updateFCMToken();
      return true;
    } else {
      return false;
    }

    // logEvent('get_profile');
  }

  Future<void> updateFCMToken() async {
    FirebaseMessaging.instance.getToken().then((value) async {
      String? token = value;
      if (userModel.fcmToken != token) {
        userModel.fcmToken = token!;
        await createUser(userModel);
      }
    });
  }

  Future<void> createUser(UserModel user) async {
    await kfirestore
        .collection(usersCollection)
        .doc(user.userId)
        .set(user.toJson());
    userModel = user;
  }

  Future<bool> deleteUser({required String password}) async {
    try {
      User user = _firebaseAuth.currentUser!;
      AuthCredential credentials = EmailAuthProvider.credential(
          email: userModel.email, password: password);
      //print(user);
      UserCredential result =
          await user.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user!.uid)
          .deleteuser(); // called from database class
      await result.user!.delete();
      await FirebaseFirestore.instance
          .collection('vars')
          .doc('vars')
          .update({'userCount': FieldValue.increment(-1)}); //1-r horogduulah
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<UserModel> getUserdata({userId}) async {
    var snapshot =
        await kfirestore.collection(usersCollection).doc(userId).get();
    Map<String, dynamic>? data = snapshot.data();
    UserModel user;
    if (snapshot.exists) {
      user = UserModel.fromJson(data!);
    } else {
      user = UserModel(
          userId: 'userId',
          firstName: 'firstName',
          lastName: 'lastName',
          email: 'email',
          username: 'username',
          phone: 'phone',
          fcmToken: 'fcmToken',
          createdAt: 'createdAt',
          role: 'role',
          profileImage: 'profileImage');
    }

    if (kDebugMode) {
      print(user);
    }
    return user;
  }

  Future<void> forgotPassword({required String email}) async {
    //print(email);
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

enum AuthStatus {
  notDetermined,
  notLoggedIn,
  loggedIn,
}
