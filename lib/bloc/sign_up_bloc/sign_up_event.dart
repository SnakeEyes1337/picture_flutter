import 'package:equatable/equatable.dart';
import 'package:picture_flutter/bloc/sign_up_bloc/sign_up_state.dart';


abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpEvent{
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignUpEvent{
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class DisplayNameChanged extends SignUpEvent{
  const DisplayNameChanged({required this.displayName});

  final String displayName;

  @override
  List<Object> get props => [displayName];
}

class FormSubmitted extends SignUpEvent{}

class FormFailure extends SignUpEvent{}




