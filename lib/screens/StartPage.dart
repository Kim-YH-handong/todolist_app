import 'package:final_project/screens/AddPage.dart';
import 'package:final_project/style/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var palette = Palette();
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
                onPressed: ()  {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                },
                child: Text("LOGOUT")),
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: height * 0.03,
                ),
                TextButton(
                    onPressed: (){
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
                    onPressed: (){
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
                    onPressed: (){
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
                child: Container(
                  height: height * 0.3,
                  child: Padding(
                    padding: EdgeInsets.all(height*0.05),
                    child: Center(
                        child: Text(
                      "우리가 알거니와 하나님을 사랑하는자 곧 그의 뜻대로 부르심을입은 자들에게는 모든 것이 합력하여 선을 이루느니라",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: height * 0.02, color: palette.white),
                    )),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: palette.mainGreen,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
