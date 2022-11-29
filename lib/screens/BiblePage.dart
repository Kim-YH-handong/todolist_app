import 'package:final_project/model/Bible.dart';
import 'package:final_project/style/palette.dart';
import 'package:flutter/material.dart';

class BiblePageArguments {
  BiblePageArguments({required this.bible});

  final Bible bible;
}

class BiblePage extends StatefulWidget {
  const BiblePage({Key? key}) : super(key: key);

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  @override
  Widget build(BuildContext context) {
    var palette = Palette();
    var height = MediaQuery.of(context).size.height;
    final args =
        ModalRoute.of(context)!.settings.arguments as BiblePageArguments;
    return Scaffold(
      backgroundColor: palette.mainGreen,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: palette.weakGreen,
              size: height * 0.04,
            )),
        elevation: 0,
        backgroundColor: palette.mainGreen,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            child: Center(
          child: Container(
            width: height / 3,
            margin: EdgeInsets.fromLTRB(0, height / 50, 0, 0),
            child: Column(
              children: [
                Text(
                  args.bible.script,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height / 30,
                    fontWeight: FontWeight.w600,
                    height: height * 0.003,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Text(
                  args.bible.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: height / 30,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.1,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
