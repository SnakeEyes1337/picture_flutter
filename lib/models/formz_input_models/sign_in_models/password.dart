import 'package:formz/formz.dart';

enum EmailValidationError{ invalid}

class Password extends FormzInput<String, EmailValidationError>{
  const Password.dirty([String value = ""]) : super.dirty(value);
  const Password.pure([String value = ""]) : super.pure(value);

  static final _passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'
  );

  @override
  EmailValidationError? validator(String? value) {
    return _passwordRegex.hasMatch(value ?? "")
        ? null
        :EmailValidationError.invalid;
  }

}