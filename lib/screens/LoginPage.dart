import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../style/palette.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var palette = Palette();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: height * 0.04),
          children: <Widget>[
            SizedBox(height: height * 0.2),
            Column(
              children: <Widget>[
                Image.asset('assets/logo.png', height: height * 0.14),
                SizedBox(height: height * 0.04),
              ],
            ),
            SizedBox(height: height * 0.1),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final userCredential =
                        await FirebaseAuth.instance.signInAnonymously();
                    print("Signed in with temporary account.");
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "operation-not-allowed":
                        print("Anonymous auth hasn't been enabled for this project.");
                        break;
                      default:
                        print("Unknown error.");
                    }
                  }
                },
                child: Text("Start without Login!",
                    style: TextStyle(
                        color: palette.white, fontSize: height * 0.02)),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0))),
                  backgroundColor: MaterialStateProperty.all(palette.mainGreen),
                )),
            SizedBox(
              height: height*0.02,
            ),
            ElevatedButton(
                onPressed: signInWithGoogle,
                child: Text("Google Login!",
                    style: TextStyle(
                        color: palette.dark, fontSize: height * 0.02)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(palette.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: palette.dark)))))
          ],
        ),
      ),
    );
  }
}
