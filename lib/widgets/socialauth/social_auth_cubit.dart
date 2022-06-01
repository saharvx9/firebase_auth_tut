import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tut/data/model/user/user.dart' as appUser;
import 'package:firebase_auth_tut/widgets/button/progress_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'social_auth_state.dart';

class SocialAuthCubit extends Cubit<SocialAuthState> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  SocialAuthCubit() : super(SocialAuthInitial());

  void login(SocialType type) {
    switch (type) {
      case SocialType.google:
        if(kIsWeb) _loginWithGoogleWeb();
        else _loginWithGoogle();
        break;
      case SocialType.facebook:
        _loginWithFacebook();
        break;
    }
  }

  void _loginWithGoogle() async {
    emit(GoogleAuthState(ButtonState.loading));
    try{
      final googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      emit(UserState(await _loginWithCredential(credential)));
    } catch(e,s){
      print("show error: $e");
      print("show stack trace: $s");
    } finally {
      emit(GoogleAuthState(ButtonState.enable));
    }
  }

  void _loginWithGoogleWeb() async {
    emit(GoogleAuthState(ButtonState.loading));
    try {
      final googleProvider = GoogleAuthProvider();
      googleProvider
        ..addScope('https://www.googleapis.com/auth/contacts.readonly')
        ..setCustomParameters({'login_hint': 'user@example.com'});
      final result = await _auth.signInWithPopup(googleProvider).then((value) => value.user);
      final user = appUser.User(result!.uid, result.displayName, result.email, null, null, result.photoURL);
      await _firestore.collection(dotenv.env["collection_users"]!).doc(user.id).set(user.toJson());
      emit(UserState(user));
    } catch (e, s) {
      print("show error: $e");
      print("show stack trace: $s");
    } finally {
      emit(GoogleAuthState(ButtonState.enable));
    }
  }

  void _loginWithFacebook() async {
    if(!FacebookAuth.i.isWebSdkInitialized) return;
    emit(FacebookAuthState(ButtonState.loading));
    try {
      final result = await FacebookAuth.i.login(permissions: ['public_profile', 'email']); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        // you are logged
        final accessToken = result.accessToken!;
        if (kDebugMode) {
          print("show access token: ${accessToken.token}");
          print("show grantedPermissions: ${accessToken.grantedPermissions}");
          print("show message: ${result.message}");
        }
        final facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);
        emit(UserState(await _loginWithCredential(facebookAuthCredential)));
      } else {
        print(result.status);
        print(result.message);
      }
    } catch (e, s) {
      print("show error: $e");
      print("show stack trace: $s");
    } finally {
      emit(FacebookAuthState(ButtonState.enable));
    }
  }

  Future<appUser.User> _loginWithCredential(AuthCredential credential) async {
    final result = await _auth.signInWithCredential(credential).then((value) => value.user);
    final user = appUser.User(result!.uid,result.email,result.displayName,null,null,result.photoURL);
    await _firestore.collection(dotenv.env["collection_users"]!).doc(user.id).set(user.toJson());
    return user;
  }
}
