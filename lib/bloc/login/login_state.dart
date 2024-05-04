import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  const LoginSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class PasswordVisibilityChanged extends LoginState {
  final bool isPasswordVisible;

  const PasswordVisibilityChanged({required this.isPasswordVisible});

  @override
  List<Object> get props => [isPasswordVisible];
}
