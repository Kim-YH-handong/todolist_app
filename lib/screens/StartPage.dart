import 'dart:math';

import 'package:final_project/model/Bible.dart';
import 'package:final_project/screens/AddPage.dart';
import 'package:final_project/screens/BiblePage.dart';
import 'package:final_project/screens/TodoPage.dart';
import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Biblestate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var palette = Palette();
    bool isBibleReady = false;

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
                child: Consumer<BibleState>(builder: (context, bible, child){
                  Bible _bible = bible.get_bible();
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/bible',
                      arguments: BiblePageArguments(bible: _bible));
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
                                    text: "${_bible.script}\n",
                                    style: TextStyle(
                                        fontSize: height * 0.02,
                                        color: palette.white)),
                                TextSpan(
                                    text: "\n${_bible.title}",
                                    style: TextStyle(
                                        fontSize: height * 0.02,
                                        color: palette.white)),
                              ]),
                            )),
                      ),
                    ),
                  );
                })
            )
          ],
        ),
      ),
    );
  }
}
