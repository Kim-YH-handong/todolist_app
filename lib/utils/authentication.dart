import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/LoginPage.dart';
import 'package:final_project/screens/StartPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return LoginPage();
          } else {
            User? user = FirebaseAuth.instance.currentUser;
            if (user!.isAnonymous == false) {
              FirebaseFirestore.instance.collection('user').doc(user?.uid).set({
                'email': user?.email,
                'name': user?.displayName,
                'image': user?.photoURL,
                'uid': user?.uid
              });
            } else {
              FirebaseFirestore.instance
                  .collection('user')
                  .doc(user?.uid)
                  .set({'uid': user?.uid});
            }
            return StartPage();
          }
        },
      ),
    );
  }
}
