import 'dart:math';
import 'package:final_project/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class CustomizePage extends StatelessWidget {
  const CustomizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var palette = Palette();
    return Scaffold(
      backgroundColor: palette.white,
      appBar: AppBar(
        title: Text(
          "프로필 사용자화",
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FluttermojiCircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: min(600, _width * 0.85),
                child: Row(
                  children: [
                    Text(
                      "Customize:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Spacer(),
                    FluttermojiSaveWidget(),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: FluttermojiCustomizer(
                  scaffoldWidth: min(600, _width * 0.85),
                  autosave: false,
                  theme: FluttermojiThemeData(
                      boxDecoration: BoxDecoration(boxShadow: [BoxShadow()])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}