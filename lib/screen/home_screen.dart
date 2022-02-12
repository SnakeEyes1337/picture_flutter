import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picture_flutter/servises/firebase_servise.dart';
import 'package:picture_flutter/servises/firestore_servises.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class HomePage extends StatelessWidget {
  MyUser user;
  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.avatarUrl.toString()),
                        radius: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(user.name.toString())
                    ],
                  ),
                  actions: [
                    IconButton(onPressed: (){
                      FirebaseServises().firebaseLogout();
                    },
                        icon: Icon(Icons.logout))

                  ],

                ),
              );
  }
}
