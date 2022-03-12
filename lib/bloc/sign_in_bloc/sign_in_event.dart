import 'package:equatable/equatable.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/email.dart';

abstract class SignInEvent extends Equatable{
  const SignInEvent();

  @override
  List<Object> get props=>[];
}

class OnChangeEmail extends SignInEvent{
  const OnChangeEmail({required this.email});
  final String email;

  @override
  List<Object> get props=>[email];
}

class OnChangePassword extends SignInEvent{
  const OnChangePassword({required this.password});
  final String password;

  @override
  List<Object> get props=>[password];
}

class OnFormSubmit extends SignInEvent{}