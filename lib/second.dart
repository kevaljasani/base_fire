import 'package:base_fire/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class second extends StatefulWidget {

  String name;
  String email;

  second(this.name,this.email);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: Column(
        children: [

          Text("${widget.name}"),
          Text("${widget.email}"),
          
          ElevatedButton(onPressed: () async {

            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return first();
            },));

          }, child: Text("Log Out"))

        ],
      ),
    );
  }
}
