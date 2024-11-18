/*

Auth Repository - This repository is responsible for handling all the authentication related operations.

*/

import 'package:kidscore/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword(
      {required String email, required String password});
  Future<AppUser?> registerWithEmailAndPassword(
      {required String email, required String password, required String name});
  Future<AppUser?> loginWithGoogle();
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
