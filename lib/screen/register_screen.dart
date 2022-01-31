import 'package:flutter/material.dart';
import 'package:picture_flutter/servises/firebase_servise.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  var _formKey = GlobalKey<FormState>();

  TextEditingController _textEmailEditingController = TextEditingController();
  TextEditingController _textNameEditingController = TextEditingController();
  TextEditingController _textPasswordEditingController = TextEditingController();

   Widget emailTextEditing(){
     return TextFormField(
       controller:_textEmailEditingController,
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
       controller:_textPasswordEditingController,
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
   Widget nameTextEditing(){
     return TextFormField(
       controller:_textNameEditingController,
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
               nameTextEditing(), SizedBox(height: 12.0,),
               passwordTextEditing(),SizedBox(height: 12.0,),
               RaisedButton(onPressed: (){
                 MyUser user = MyUser(
                   email: _textEmailEditingController.text,
                   name: _textNameEditingController.text,
                 );
                 FirebaseServises().firebaseSignUp(user: user, password:_textPasswordEditingController.text,
                     validator: _formKey.currentState!.validate());
                 Navigator.pop(context);
               },
                 child: Text("SignIn", style: TextStyle(fontSize: 16, color: Colors.white),),
                 padding: EdgeInsets.fromLTRB(100, 2, 100, 2),
                 color: Colors.red,),

             ],
           ),
         ),
       ),
     );
  }
}
