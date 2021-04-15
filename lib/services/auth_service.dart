
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser;

  Stream<User> authStateChanges() => _auth.authStateChanges();

  // Sign In Anon
  Future<User> signInAnon() async{
    try{
      final userCredentials = await _auth.signInAnonymously();
      return userCredentials.user;
    }catch(e){
        print(e.toString());
        return null;
    }
  }


  Future<User> signInGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if(googleUser != null){
      final googleAuth = await googleUser.authentication;
      if(googleAuth.idToken != null){
        final userCredentials = await  _auth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        ));
        return userCredentials.user;
      }else{
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID token'
        );
      }
    }else{
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign aborted by user'
      );
    }
  }

  Future<User> facebookSignIn()async{
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    switch (response.status){
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredentials = await _auth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token));
        return userCredentials.user;
        break;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign aborted by user'
        );
        break;
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
            code: 'ERROR_FACEBOOK_LOGIN_FAILED',
            message: response.error.developerMessage,
        );
        break;
      default:
        throw UnimplementedError();
    }
  }


  Future<User> signUpWithEmailPass(String email, String password) async{
    final userCredentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredentials.user;
  }


  // sign Out
  Future signOut() async{
    try{
        final googleSign = GoogleSignIn();
        final fb = FacebookLogin();
        await googleSign.signOut();
        await fb.logOut();
        await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}