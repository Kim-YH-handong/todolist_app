import 'package:final_project/screens/AddPage.dart';
import 'package:final_project/screens/BiblePage.dart';
import 'package:final_project/screens/DetailPage.dart';
import 'package:final_project/screens/PlanPage.dart';
import 'package:final_project/screens/RemarkPage.dart';
import 'package:final_project/screens/StartPage.dart';
import 'package:final_project/screens/TodoPage.dart';
import 'package:final_project/utils/Biblestate.dart';
import 'package:final_project/utils/Todostate.dart';
import 'package:final_project/utils/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TodoState>(
        lazy: false,
        create: (context) => TodoState(),
      ),
      ChangeNotifierProvider<BibleState>(
        lazy: false,
        create: (context) => BibleState(),
      )
    ],
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return PageRouteAnimator(
                child: Authentication(),
                routeAnimation: RouteAnimation.topLeftToBottomRight);

          case '/todo':
            return PageRouteAnimator(
              child: TodoPage(),
              routeAnimation: RouteAnimation.bottomToTop,
              settings: const RouteSettings(arguments: 'I am going'),
              curve: Curves.slowMiddle,
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
            );

          case '/remark':
            return PageRouteAnimator(
              child: RemarkPage(),
              routeAnimation: RouteAnimation.bottomToTop,
              curve: Curves.slowMiddle,
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 500),
            );

          case '/plan':
            return PageRouteAnimator(
              child: PlanPage(),
              routeAnimation: RouteAnimation.bottomToTop,
              curve: Curves.slowMiddle,
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 500),
            );
        }
      },
      routes: {
        '/login': (BuildContext context) => Authentication(),
        '/add': (BuildContext context) => AddPage(),
        '/start': (BuildContext context) => StartPage(),
        '/bible': (BuildContext context) => BiblePage(),
        '/detail': (BuildContext context) => DetailPage(),
      },
    );
  }
}
