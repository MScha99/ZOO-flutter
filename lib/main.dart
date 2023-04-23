import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//poniżej ekrany
import 'package:zooapp/widgets/navigationbar.dart';
import 'package:zooapp/screens/homescreen.dart';
import 'package:zooapp/screens/tourprogramscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'ZOO Wrocław',
      theme: ThemeData(colorSchemeSeed: Color(0xFFF5ECE4)
          // This is the theme of your application.
          ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/program',
      builder: (context, state) => TourProgramScreen(),
    ),
  ],
);
