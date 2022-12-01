import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project/style/palette.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    var palette = Palette();

    return Scaffold(
        backgroundColor: palette.white,
        appBar: AppBar(
          title: Text(
            "프로필",
            style: TextStyle(color: palette.dark),
          ),
          elevation: 0,
          backgroundColor: palette.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: palette.strongBlue),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
                icon: Icon(Icons.logout, color: palette.strongBlue),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                }),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              GestureDetector(
                child: FluttermojiCircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 100,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/customize');
                },
              ),
              SizedBox(
                height: 70,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "${FirebaseAuth.instance.currentUser!.isAnonymous == true
                            ?"파란너구리":FirebaseAuth.instance.currentUser!.displayName}",
                        style: TextStyle(fontSize: 25, color: palette.dark)),
                    TextSpan(
                        text: ' 님',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: palette.dark)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
