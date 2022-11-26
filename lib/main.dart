import 'package:final_project/screens/AddPage.dart';
import 'package:final_project/screens/StartPage.dart';
import 'package:final_project/utils/Todostate.dart';
import 'package:final_project/utils/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<TodoState>(
    lazy: false,
    create: (context) => TodoState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOLIST',
      theme: ThemeData(),
      initialRoute: '/login',
      routes: {
        '/login' : (BuildContext context) => Authentication(),
        '/add' : (BuildContext context) => AddPage(),
        '/start' : (BuildContext context) => StartPage(),
        // '/bible' : (BuildContext context) => BiblePage(),
        // '/detail' : (BuildContext context) => DetailPage(),
      },
    );
  }
}
