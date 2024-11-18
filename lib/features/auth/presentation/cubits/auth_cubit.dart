/*

Auth Cubit: state management for authentication

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidscore/features/auth/domain/entities/app_user.dart';
import 'package:kidscore/features/auth/domain/repository/auth_repo.dart';
import 'package:kidscore/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // check if user is authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // get current user
  AppUser? get currentUser => _currentUser;

  //login with email + pw
  Future<void> login(String email, String pw) async {
    try {
      emit(AuthLoading());
      final user =
          await authRepo.loginWithEmailAndPassword(email: email, password: pw);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //register with email + pw
  Future<void> register(String email, String pw, String name) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.registerWithEmailAndPassword(
          email: email, password: pw, name: name);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    await authRepo.logout();
    emit(Unauthenticated());
  }
}
