import 'package:flutter/material.dart';
import 'package:picture_flutter/servises/firebase_servise.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  var _formKey= GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =  TextEditingController();
  final TextEditingController _passwordTextEditingController =  TextEditingController();

  Widget emailTextEditing(){
    return TextFormField(
      controller:_emailTextEditingController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white,
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
        )
      ),
      validator: (value){
        if(value!.isEmpty){
          return "Enter your email";
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9_.-]+.[a-z]").hasMatch(value)){
          return "Enter validate email";
        }
      },
    );
  }
  Widget passwordTextEditing(){
    return TextFormField(
      controller:_passwordTextEditingController,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          focusColor: Colors.white,
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
      ),
      validator: (value){
        if(value!.isEmpty){
          return "Enter your password";
        }
        if(!RegExp(r"^.{6,}$").hasMatch(value)){
          return "Enter validate password (min 6 symbols)";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [emailTextEditing(),SizedBox(height: 12.0,),
                passwordTextEditing(),SizedBox(height: 12.0,),
                RaisedButton(onPressed: (){
                  FirebaseServises().firebaseSignIn(email: _emailTextEditingController.text, password:_passwordTextEditingController.text,
                      validator: _formKey.currentState!.validate());
                },
                child: Text("SignIn", style: TextStyle(fontSize: 16, color: Colors.white),),
                padding: EdgeInsets.fromLTRB(100, 2, 100, 2),
                color: Colors.red,)
              ],
            ),
          ),
        ),
    );
  }
}
