import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/email.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/password.dart';

class SignInState extends Equatable{
  SignInState({this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.email = const Email.pure()
  });

  final Email email;
  final Password password;
  final FormzStatus status;

  SignInState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status
}){
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status
    );
  }

  @override
  List<Object> get props => [email, password, status];
}