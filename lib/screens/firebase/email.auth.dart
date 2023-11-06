import 'package:firebase_auth/firebase_auth.dart';

class mailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> createUSer(
      {required String emailUser, required String passUser}) async {
    try {
      final credencials = await auth.createUserWithEmailAndPassword(
          email: emailUser, password: passUser);
      credencials.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validUser(
      {required String emailUser, required String passUser}) async {
    try {
      final credencials = await auth.signInWithEmailAndPassword(
          email: emailUser, password: passUser);
      if (credencials.user!.emailVerified) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
