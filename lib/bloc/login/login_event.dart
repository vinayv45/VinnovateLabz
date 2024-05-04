import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginEvent {}

final class UsernameChanged extends LoginEvent {
  final String username;
  const UsernameChanged({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}

final class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged({
    required this.password,
  });

  @override
  List<Object?> get props => [password];
}

class FormSubmitted extends LoginEvent {
  final String username;
  final String password;

  const FormSubmitted({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class TogglePasswordVisibility extends LoginEvent {}
