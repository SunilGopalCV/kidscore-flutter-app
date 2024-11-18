import 'package:firebase_auth/firebase_auth.dart';
import 'package:kidscore/features/auth/domain/entities/app_user.dart';
import 'package:kidscore/features/auth/domain/repository/auth_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // attempt to sign in with email and password
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      return user;
    } catch (e) {
      throw Exception('login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      // attempt to sign up with email and password
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      return user;
    } catch (e) {
      throw Exception('login failed: $e');
    }
  }

  @override
  Future<AppUser?> loginWithGoogle() async {
    try {
      // Step 1: Trigger the Google Sign-In process
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in aborted by user');
      }

      // Step 2: Obtain the Google authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Step 3: Create a Firebase credential with the Google auth details
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: Sign in to Firebase using the Google credential
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      // Create user object
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userCredential.user!.displayName ?? '',
      );

      return user;
    } catch (e) {
      throw Exception('Google login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    return firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // get current user
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!, name: '');
  }
}
