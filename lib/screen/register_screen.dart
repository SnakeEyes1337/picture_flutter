import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:picture_flutter/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:picture_flutter/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:picture_flutter/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:picture_flutter/servises/firebase_servise.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  var _formKey = GlobalKey<FormState>();

  TextEditingController _textEmailEditingController = TextEditingController();
  TextEditingController _textNameEditingController = TextEditingController();
  TextEditingController _textPasswordEditingController = TextEditingController();

   // Widget emailTextEditing(){
   //   return TextFormField(
   //     controller:_textEmailEditingController,
   //     keyboardType: TextInputType.emailAddress,
   //     cursorColor: Colors.white,
   //     style: TextStyle(color: Colors.white),
   //     decoration: InputDecoration(
   //         focusColor: Colors.white,
   //         hoverColor: Colors.white,
   //         hintStyle: TextStyle(color: Colors.white),
   //         hintText: "Email",
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
   //     controller:_textPasswordEditingController,
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
   // Widget nameTextEditing(){
   //   return TextFormField(
   //     controller:_textNameEditingController,
   //     style: TextStyle(color: Colors.white),
   //     cursorColor: Colors.white,
   //     decoration: InputDecoration(
   //         focusColor: Colors.white,
   //         hoverColor: Colors.white,
   //         hintStyle: TextStyle(color: Colors.white),
   //         hintText: "Name",
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
   //         return "Enter your Name";
   //       }
   //       if(!RegExp(r"^.{3,}$").hasMatch(value)){
   //         return "Enter validate name (min 3 symbols)";
   //       }
   //     },
   //   );
   // }

   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (_)=>SignUpBloc(),
       child: Scaffold(
         backgroundColor: Colors.black,
         body: BlocListener<SignUpBloc, SignUpState>(
           listener: (context,state){
             if(state.status.isSubmissionSuccess){
               ScaffoldMessenger.of(context).hideCurrentSnackBar();
               showDialog(context: context,
                   builder: (_)=>SuccessDialog());
             }
             if(state.status.isSubmissionInProgress){
               ScaffoldMessenger.of(context)
                 ..hideCurrentSnackBar()
                 ..showSnackBar(
                   const SnackBar(content: Text('Submitting...')));
             }

             if(state.status.isSubmissionFailure){
               ScaffoldMessenger.of(context)
                 ..hideCurrentSnackBar()
                 ..showSnackBar(
                     const SnackBar(content: Text('Fail...')));
             }

           },
           child: Form(
             key: _formKey,
             child: Padding(
               padding: const EdgeInsets.all(12.0),
               child: Column(

                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [EmailInput(),SizedBox(height: 12.0,),
                   DisplayNameInput(), SizedBox(height: 12.0,),
                   PasswordInput(),SizedBox(height: 12.0,),
                   SubmitButton()
                   // RaisedButton(onPressed: (){
                   //   // MyUser user = MyUser(
                   //   //   email: _textEmailEditingController.text,
                   //   //   name: _textNameEditingController.text,
                   //   // );
                   //   // FirebaseServises().firebaseSignUp(user: user, password:_textPasswordEditingController.text,
                   //   //     validator: _formKey.currentState!.validate());
                   //   // Navigator.pop(context);
                   // },
                   //   child: Text("SignIn", style: TextStyle(fontSize: 16, color: Colors.white),),
                   //   padding: EdgeInsets.fromLTRB(100, 2, 100, 2),
                   //   color: Colors.red,),

                 ],
               ),
             ),
           ),
         ),
       ),
     );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc , SignUpState >(
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
              context.read<SignUpBloc>().add(EmailChanged(email: value));
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
    return BlocBuilder<SignUpBloc , SignUpState>(
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
              context.read<SignUpBloc>().add(PasswordChanged(password: value));
            },
          );
        }
    );
  }
}

class DisplayNameInput extends StatelessWidget {
  const DisplayNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc , SignUpState>(
        builder: (context , state){
          return TextFormField(
            style: TextStyle(color: Colors.white),
            initialValue: state.displayName.value,
            decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Display Name",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)
                ),
                errorText: state.displayName.invalid
                    ? "Please ensure the name is valid"
                    : null
            ),
            onChanged: (value){
              context.read<SignUpBloc>().add(DisplayNameChanged(displayName: value));
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
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state){
          return  RaisedButton(onPressed: (){
              context.read<SignUpBloc>().add(FormSubmitted());
          },
            child: Text("SignIn", style: TextStyle(fontSize: 16, color: Colors.white),),
            padding: EdgeInsets.fromLTRB(100, 2, 100, 2),
            color: Colors.red,);

        }
    );
  }
}



class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
