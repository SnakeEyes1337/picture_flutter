
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:picture_flutter/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:picture_flutter/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/display_name.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/email.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/password.dart';
import 'package:picture_flutter/servises/firebase_servise.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  SignUpBloc() : super(SignUpState()){
    on<EmailChanged>(_onEmailChaged);
    on<PasswordChanged>(_onPasswordChanged);
    on<DisplayNameChanged>(_onDisplayNameChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

 void _onEmailChaged(EmailChanged event, Emitter<SignUpState> emit){
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
      status: Formz.validate([email, state.password, state.displayName])
    ));
 }

 void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emitter){
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password.valid ? password : Password.pure(event.password),

      status: Formz.validate([state.email, password, state.displayName])
    ));
 }

 void _onDisplayNameChanged(DisplayNameChanged event , Emitter<SignUpState> emit){
    final displayName= DisplayName.dirty(event.displayName);
    emit(state.copyWith(
      displayName: displayName.valid ? displayName : DisplayName.pure(event.displayName),
      status:  Formz.validate([state.email, state.password, displayName])
    ));
 }

 void _onFormSubmitted(FormSubmitted event , Emitter<SignUpState> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final displayName = DisplayName.dirty(state.displayName.value);

    emit(state.copyWith(
      email: email,
      password: password,
      displayName: displayName,
      status: Formz.validate([email,displayName, password])
    ));
    if(state.status.isValidated){
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future.delayed(Duration(seconds: 1));
      MyUser user = MyUser(email: state.email.value, name: state.displayName.value );
      FirebaseServises().firebaseSignUp(user: user, password:state.password.value  );
    }
    if(state.status.isInvalid){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }

 }



}
