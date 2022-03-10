import 'package:formz/formz.dart';

enum EmailValidationError{ invalid}

class DisplayName extends FormzInput<String, EmailValidationError>{
  const DisplayName.dirty([String value = ""]) : super.dirty(value);
  const DisplayName.pure([String value = ""]) : super.pure(value);

  static final _displayNameRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]{3,}'
  );

  @override
  EmailValidationError? validator(String? value) {
    return _displayNameRegex.hasMatch(value ?? "")
        ? null
        :EmailValidationError.invalid;
  }

}