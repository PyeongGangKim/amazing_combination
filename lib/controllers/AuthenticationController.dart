import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

enum ApplicationLoginState{
  loggedOut,
  googleLogin,
}

class AuthenticationController extends GetxController{

  void signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    _auth = userCredential.user;
  }

    User _auth;
    User get auth => _auth;

    ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
    ApplicationLoginState get loginState => _loginState;
}