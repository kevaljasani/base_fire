import 'package:base_fire/second.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main()
async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(home: first(),));
}

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  final user = FirebaseAuth.instance.currentUser;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
  void initState() {


    if (user != null) {
    // Name, email address, and profile photo URL
       String name = user!.displayName.toString();
       String email = user!.email.toString();

       Navigator.push(context,MaterialPageRoute(builder: (context) {
         return second(name,email);
         },) );
       setState(() {

       });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      
      body:Center(
        
        child: ElevatedButton(onPressed: () {

          signInWithGoogle().then((value) {

            String name,email;

            name=value.user!.displayName.toString();
            email=value.user!.email.toString();

            Navigator.push(context,MaterialPageRoute(builder: (context) {
              return second(name,email);
            },) );

            setState(() {

            });
          },);

        }, child: Text("Submit")),
      )
    );
  }
}
