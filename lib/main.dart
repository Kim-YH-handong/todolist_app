import 'package:final_project/screens/StartPage.dart';
import 'package:final_project/style/palette.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        child: StartPage(),
      ),
    );
  }
}
