import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:picture_flutter/bloc/sign_in_bloc/sign_in_event.dart';


import 'package:picture_flutter/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:picture_flutter/screen/register_screen.dart';
import 'package:picture_flutter/servises/firebase_servise.dart';
import '../bloc/sign_in_bloc/sign_in_bloc.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  var _formKey= GlobalKey<FormState>();
  // final TextEditingController _emailTextEditingController =  TextEditingController();
  // final TextEditingController _passwordTextEditingController =  TextEditingController();
  //
  // Widget emailTextEditing(){
  //   return TextFormField(
  //     controller:_emailTextEditingController,
  //     keyboardType: TextInputType.emailAddress,
  //     cursorColor: Colors.white,
  //     style: TextStyle(color: Colors.white),
  //     decoration: InputDecoration(
  //       focusColor: Colors.white,
  //       hoverColor: Colors.white,
  //       hintStyle: TextStyle(color: Colors.white),
  //       hintText: "Email",
  //       enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide(color: Colors.white)
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10),
  //         borderSide: BorderSide(color: Colors.white)
  //       )
  //     ),
  //     validator: (value){
  //       if(value!.isEmpty){
  //         return "Enter your email";
  //       }
  //       if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9_.-]+.[a-z]").hasMatch(value)){
  //         return "Enter validate email";
  //       }
  //     },
  //   );
  // }
  // Widget passwordTextEditing(){
  //   return TextFormField(
  //     controller:_passwordTextEditingController,
  //     style: TextStyle(color: Colors.white),
  //     cursorColor: Colors.white,
  //     decoration: InputDecoration(
  //         focusColor: Colors.white,
  //         hoverColor: Colors.white,
  //         hintStyle: TextStyle(color: Colors.white),
  //         hintText: "Password",
  //         enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //             borderSide: BorderSide(color: Colors.white)
  //         ),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //             borderSide: BorderSide(color: Colors.white)
  //         )
  //     ),
  //     validator: (value){
  //       if(value!.isEmpty){
  //         return "Enter your password";
  //       }
  //       if(!RegExp(r"^.{6,}$").hasMatch(value)){
  //         return "Enter validate password (min 6 symbols)";
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SignInBloc(),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: BlocListener<SignInBloc, SignInState>(
                listener:(context, state) {
                  if(state.status == FormzStatus.submissionSuccess){
                    Fluttertoast.showToast(msg: "Success");
                  }
                  if(state.status == FormzStatus.submissionFailure){
                    Fluttertoast.showToast(msg: "Failure");
                  }
                },
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [EmailInput(), SizedBox(height: 12.0,),
                        PasswordInput(), SizedBox(height: 12.0,),
                        SubmitButton(),
                        SizedBox(height: 1.0,),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => RegisterScreen()));
                        },
                            child: Text(
                              "Doesn`t have  account? You can Register",
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline
                              ),)
                        )
                      ],
                    ),
                  ),
                )
            )
        )
     );
    }
  }

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc , SignInState >(
        builder:(context, state){
          return TextFormField(
            initialValue:  state.email.value,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Email",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)
                ),
                errorText: state.email.invalid
                    ? "Please ensure the email is valid"
                    : null
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value){
              context.read<SignInBloc>().add(OnChangeEmail(email: value));
            },
            textInputAction: TextInputAction.next,
          );
        } );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc , SignInState>(
        builder: (context , state){
          return TextFormField(
            initialValue: state.password.value,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(focusColor: Colors.white,
                hoverColor: Colors.white,
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Password",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)
                )
                ,
                errorText: state.password.invalid
                    ? "Please ensure the password is valid"
                    : null
            ),
            onChanged: (value){
              context.read<SignInBloc>().add(OnChangePassword(password: value));
            },
          );
        }
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return RaisedButton(onPressed: () {
            context.read<SignInBloc>().add(OnFormSubmit());
          },
            child: Text(
              "SignIn", style: TextStyle(fontSize: 16, color: Colors.white),),
            padding: EdgeInsets.fromLTRB(100, 2, 100, 2),
            color: Colors.red,);
        }
    );
  }
}