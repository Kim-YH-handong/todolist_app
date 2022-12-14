import 'dart:async';
import 'package:final_project/model/Bible.dart';
import 'package:final_project/screens/BiblePage.dart';
import 'package:final_project/style/palette.dart';
import 'package:final_project/utils/Biblestate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    child: FluttermojiCircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 25,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${FirebaseAuth.instance.currentUser!.isAnonymous == true
                      ?"???????????????"
                      :FirebaseAuth.instance.currentUser!.displayName}",
                    style: TextStyle(fontSize: 18),),
                  Text(
                    " ???",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
            ),
            FutureBuilder(
                future: getWeather(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //?????? ????????? data??? ?????? ?????? ?????? ???????????? ???????????? ????????? ????????????.
                  if (snapshot.hasData == false) {
                    return CircularProgressIndicator();
                  }
                  //error??? ???????????? ??? ?????? ???????????? ?????? ??????
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  // ???????????? ??????????????? ???????????? ?????? ?????? ????????? ???????????? ?????? ?????????.
                  else {
                    return ListTile(
                      title: Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(5),
                          //leading. ?????? ?????? ???????????? ??????. ????????? ?????? ????????? trailing ???????????? ?????? ??????
                          leading: Image.network(icon_url),
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
                }),
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
                      "?????? ??? ???",
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
                      "??????",
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
                      "????????? ??????",
                      style: TextStyle(
                          fontSize: height * 0.025, color: palette.dark),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                "????????? ????????????",
                style: TextStyle(
                    fontSize: height * 0.03, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Consumer<BibleState>(builder: (context, bible, child) {
                  Color bbC = palette.bbYellow;;
                  Bible _bible = bible.get_bible();
                  if (_bible.bbC == 'red') {
                    bbC = palette.bbRed;
                  } else if (_bible.bbC == 'yellow') {
                    bbC = palette.bbYellow;
                  } else if (_bible.bbC == 'pink') {
                    bbC = palette.bbPink;
                  } else if (_bible.bbC == 'blue') {
                    bbC = palette.bbBlue;
                  } else if (_bible.bbC == 'green') {
                    bbC = palette.bbGreen;
                  } else if (_bible.bbC == 'violet') {
                    bbC = palette.bbViolet;
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/bible',
                          arguments: BiblePageArguments(bible: _bible));
                    },
                    child: Container(
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: bbC,
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
                }))
          ],
        ),
      ),
    );
  }
}
