import 'dart:math';

import 'package:final_project/model/Bible.dart';
import 'package:final_project/screens/BiblePage.dart';
import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Biblestate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var palette = Palette();
    List<Bible> _biblelist = context.watch<BibleState>().bible;
    int randomBibleIndex =
        Random().nextInt(1); //여기에 우리가 얼마나 만들었는지 넣어주자. 지금은 성경 1임.
    return Scaffold(
      backgroundColor: palette.white,
      appBar: AppBar(
        title: Text("Hello"),
        backgroundColor: palette.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
                child: Text("LOGOUT")),
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: height * 0.03,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/todo');
                    },
                    child: Text(
                      "오늘 할 일",
                      style: TextStyle(
                          fontSize: height * 0.025, color: palette.dark),
                    ))
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.star_border_outlined,
                  size: height * 0.03,
                  color: palette.mainRed,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/remark');
                    },
                    child: Text(
                      "중요",
                      style: TextStyle(
                          fontSize: height * 0.025, color: palette.dark),
                    ))
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: height * 0.03,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/plan');
                    },
                    child: Text(
                      "계획된 일정",
                      style: TextStyle(
                          fontSize: height * 0.025, color: palette.dark),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                "오늘의 동기부여",
                style: TextStyle(
                    fontSize: height * 0.03, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/bible',
                        arguments: BiblePageArguments(
                            bible: _biblelist[randomBibleIndex]));
                  },
                  child: Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: palette.mainGreen,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(height * 0.05),
                      child: Center(
                          child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(text: '', children: <TextSpan>[
                          TextSpan(
                              text: "${_biblelist[randomBibleIndex].script}\n",
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: palette.white)),
                          TextSpan(
                              text: "\n${_biblelist[randomBibleIndex].title}",
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: palette.white)),
                        ]),
                      )),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
