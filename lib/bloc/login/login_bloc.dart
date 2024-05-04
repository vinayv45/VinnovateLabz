import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/bloc/login/login_event.dart';
import 'package:taskapp/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isPasswordVisible = false;
  LoginBloc() : super(const LoginState()) {
    on<UsernameChanged>(_usernameChangedEvent);
    on<PasswordChanged>(_passwordChangedEvent);
    on<FormSubmitted>(_loginButtonPressedEvent);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
  }

  FutureOr<void> _loginButtonPressedEvent(
      FormSubmitted event, Emitter<LoginState> emit) async {
    final username = event.username;
    final password = event.password;
    if (username.isEmpty || password.isEmpty) {
      emit(const LoginFailure(
          error: 'Please enter both username and password.'));
      return;
    }
    emit(LoginLoading());
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        emit(const LoginSuccess(message: 'Login successful!'));
      } else {
        emit(const LoginFailure(error: 'Login failed!'));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            emit(const LoginFailure(
                error: 'User not found for provided email.'));
            break;
          case 'wrong-password':
            emit(const LoginFailure(error: 'Incorrect password provided.'));
            break;
          default:
            emit(LoginFailure(error: e.message.toString()));
            break;
        }
      } else {
        emit(LoginFailure(error: e.toString()));
      }
    }
  }

  FutureOr<void> _usernameChangedEvent(
      UsernameChanged event, Emitter<LoginState> emit) async {
    final username = event.username;
    if (username.isEmpty) {
      emit(const LoginFailure(error: 'enter username'));
    }
  }

  FutureOr<void> _passwordChangedEvent(
      PasswordChanged event, Emitter<LoginState> emit) async {
    final password = event.password;
    if (password.isEmpty) {
      emit(const LoginFailure(error: 'enter password'));
    }
  }

  void _togglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged(isPasswordVisible: isPasswordVisible));
  }
}
