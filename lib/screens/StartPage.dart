import 'dart:async';
import 'package:final_project/model/Bible.dart';
import 'package:final_project/screens/BiblePage.dart';
import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Biblestate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late Weather w;
  String icon_url = "";

  @override
  void initState() {
    super.initState();
  }

  Future<Weather> getWeather() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    WeatherFactory wf = new WeatherFactory("3a13a9439a97e789bac0abfadbde466f",
        language: Language.KOREAN);
    var lat = position.latitude;
    var lon = position.longitude;
    w = await wf.currentWeatherByLocation(lat, lon);
    icon_url = "http://openweathermap.org/img/w/" + w.weatherIcon! + ".png";
    print(icon_url);
    return w;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var palette = Palette();

    return Scaffold(
      backgroundColor: palette.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            FutureBuilder(
                future: getWeather(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return CircularProgressIndicator();
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                  else {
                    return ListTile(
                      title: Container(

                        child: ListTile(
                          contentPadding: EdgeInsets.all(5),
                          //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
                          leading:  Image.network(icon_url),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${w.weatherDescription}',
                                style: TextStyle(
                                    color: palette.dark,
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${w.temperature}',
                                style: TextStyle(
                                  color: palette.strongBlue,
                                  fontFamily: 'Work Sans',
                                  fontSize: height * 0.015,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }

            ),
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
