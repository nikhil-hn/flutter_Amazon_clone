import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  CloudFirestoreMethods cloudFirestoreMethods = CloudFirestoreMethods();

  Future<String> signUpWithEmailandPassword(
      String name, String email, String address, String password) async {
    email.trim();
    name.trim();
    address.trim();
    password.trim();

    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        await cloudFirestoreMethods.uploadNameandAddress(
            name: name, address: address);
        return 'success';
      } else {
        return 'SignUp Failed.';
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    email.trim();
    password.trim();
    try {
      UserCredential cred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        return 'success';
      } else {
        return 'SignIp Failed.';
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
