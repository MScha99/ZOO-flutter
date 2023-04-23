import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/screens/tourprogramscreen.dart';
import 'package:zooapp/widgets/navigationbar.dart';
import 'package:zooapp/widgets/custompageroute.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyNavBar(),
      appBar: AppBar(
        title: const Text('Ekran główny'),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('test'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CustomPageRoute(builder: (context) => TourProgramScreen()),
                );
              },
              child: const Text('Go to Navigation Example'),
            ),
          ],
        ),
      ),
    );
  }
}
