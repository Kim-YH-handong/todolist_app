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
      ),
      body: Column(
        children: [
          Text("파란너구리"),
          FluttermojiCircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 20,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/customize');
                },
                child: Text("CUSTOMIZE")),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
                child: Text("LOGOUT")),
          ),
        ],
      )
    );
  }
}
