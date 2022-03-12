import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:picture_flutter/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:picture_flutter/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:picture_flutter/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/email.dart';
import 'package:picture_flutter/models/formz_input_models/sign_in_models/password.dart';
import 'package:picture_flutter/servises/firebase_servise.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  SignInBloc() : super (SignInState()){
  on<OnChangeEmail>(_onEmailChanged);
  on<OnChangePassword>(_onPasswordChanged);
  on<OnFormSubmit>(_onFormSubmitted);
  }

  void _onEmailChanged(OnChangeEmail event , Emitter<SignInState> emit){
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.password])
    ));
  }
  void _onPasswordChanged(OnChangePassword event , Emitter<SignInState> emit){
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password.valid ? password : Password.pure(event.password),

        status: Formz.validate([state.email, password])
    ));
  }

  void _onFormSubmitted(OnFormSubmit event, Emitter<SignInState> emit)async{
    final  email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password])
    ));
    if(state.status.isValidated){
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      await FirebaseServises().firebaseSignIn(email: state.email.value, password: state.password.value);
    }
    if(state.status.isInvalid){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}