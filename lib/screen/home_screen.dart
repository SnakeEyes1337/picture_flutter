import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picture_flutter/servises/firebase_servise.dart';
import 'package:picture_flutter/servises/firestore_servises.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class HomePage extends StatefulWidget {
    HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    MyUser user = MyUser();

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("users")
        .doc("userId")
        .get().then((value) {

          setState(() {
            this.user = MyUser.fromMap(value.data());
          });
        });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: FutureBuilder <DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("users")
              .doc("userId")
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            if(snapshot.hasData && !snapshot.data!.exists){
              return Text("Doesn't exist" );
            }
            if(snapshot.connectionState == ConnectionState.done){
              this.user=  MyUser.fromMap(snapshot.data);
              return Text(user.name.toString());
            }

            return Text("Loading");
          },

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
