import 'package:final_project/screens/LoginPage.dart';
import 'package:final_project/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOLIST',
      theme: ThemeData(),
      home: MultiProvider(
        providers: [
          Provider(
            create: (context) => Palette(),
          )
        ],
        child: LoginPage(),
      ),
    );
  }
}
