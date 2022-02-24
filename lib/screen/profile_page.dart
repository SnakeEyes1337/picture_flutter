import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:picture_flutter/bloc/info_user_bloc/info_user_bloc.dart';
import 'package:picture_flutter/bloc/info_user_bloc/info_user_event.dart';
import 'package:picture_flutter/bloc/info_user_bloc/info_user_state.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class ProfileInfo extends StatelessWidget {
  ProfileInfo({Key? key, required this.user}) : super(key: key);
  MyUser user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();


Widget nameFormEditing (String name){
  _nameTextEditingController.text = name;
  return SizedBox(
    width: 300,
    child: TextFormField(
      controller:_nameTextEditingController,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(

        focusColor: Colors.black,
        hoverColor: Colors.black,
        hintStyle: TextStyle(color: Colors.black),
        hintText: "Name",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black)
        )
      ),
      validator: (value){
        if(value!.isEmpty){
          return "Enter your name";
        }
        if(!RegExp(r"^.{3,}$").hasMatch(value)){
          return "Enter validate name (min: 3 simbols)";
        }
      },
    ),
  );
}
  Widget emailFormEditing(String email){
  _emailTextEditingController.text = email;
    return SizedBox(
      width: 300,
      child: TextFormField(
        maxLength: 30,
        controller:_emailTextEditingController,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            focusColor: Colors.black,
            hoverColor: Colors.black,
            hintStyle: TextStyle(color: Colors.black),
            hintText: "email",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)
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
      ),
    );
  }

  Widget passwordFormEditing (String password){
    _passwordTextEditingController.text=password;
    return SizedBox(
      child: TextFormField(
        maxLength: 30,
        controller:_passwordTextEditingController,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            focusColor: Colors.black,
            hoverColor: Colors.black,
            hintStyle: TextStyle(color: Colors.black),
            hintText: "Password",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)
            )
        ),
        validator: (value){
          if(value!.isEmpty){
            return "Enter your name";
          }
          if(!RegExp(r"^.{3,}$").hasMatch(value)){
            return "Enter validate name (min: 3 simbols)";
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> InfoUserBloc(StaticInfoState(user)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: BlocBuilder<InfoUserBloc, InfoUserState>(builder: (context, state){
              if(state is StaticInfoState){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(state.user.avatarUrl.toString()),
                      radius: 40,
                    ),
                    SizedBox(height: 5,),
                    Text("Name: ${state.user.name}", style: TextStyle(
                      fontSize: 20,
                    ),),
                    SizedBox(height: 10,),
                    Text("Email: ${state.user.email}",style: TextStyle(
                        fontSize: 20
                    ),),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      context.read<InfoUserBloc>().add(OpeningInfoUser(user));
                    },
                        child: Text("Edit profile")),
                  ],
                );
              }
              if(state is EditingInfoState){
                return Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("So easy")));
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(state.user.avatarUrl.toString()),
                            radius: 40,
                          ),
                        ),
                        SizedBox(height: 5,),
                        nameFormEditing(state.user.name.toString()),
                        SizedBox(height: 10,),
                         emailFormEditing(state.user.email.toString()),
                        SizedBox(height: 10,),
                         Container(width: 300,
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              ElevatedButton(onPressed: (){
                                context.read<InfoUserBloc>().add(ClosingInfoUser(user: user));
                              }, child:Text("Cancel")),
                              ElevatedButton(onPressed: (){}, child:Text("Save")),
                            ],),
                         ),

                      ],
                    ),
                  ),
                );
              }
              return Center();
            }),
        ),
      ),
    );
  }
}


class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key, required this.user}) : super(key: key);
  MyUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(child: ProfileInfo(user: user)),
          ],
        ),
      ],
    ));
  }


}
