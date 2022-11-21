import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../style/palette.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final palette = context.watch<Palette>();
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
                onPressed: null,
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
                onPressed: null,
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
