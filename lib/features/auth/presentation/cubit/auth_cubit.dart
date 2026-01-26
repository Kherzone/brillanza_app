import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth_repository.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authenticated extends AuthState { final User user; Authenticated(this.user); }
class AuthError extends AuthState { final String message; AuthError(this.message); }

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  AuthCubit(this._repository) : super(AuthInitial());

  Future<void> loginWithGoogle() async {
    try {
      emit(AuthLoading());
      final user = await _repository.signInWithGoogle();
      if (user != null) emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}