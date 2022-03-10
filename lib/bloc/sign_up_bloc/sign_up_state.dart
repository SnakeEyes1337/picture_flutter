import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';


import 'package:picture_flutter/models/formz_input_models/sign_in_models/display_name.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/email.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/password.dart';

class SignUpState extends Equatable{
  SignUpState({
    this.displayName = const DisplayName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage
  });

  final DisplayName displayName;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;




  SignUpState copyWith({
    DisplayName? displayName,
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage
}){
    return SignUpState(
      displayName: displayName ?? this.displayName,
      password: password ?? this.password,
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [email, password, status];
}