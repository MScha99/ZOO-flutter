import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/screens/homescreen.dart';
import 'package:zooapp/widgets/navigationbar.dart';
import 'package:zooapp/widgets/custompageroute.dart';

class TourProgramScreen extends StatelessWidget {
  const TourProgramScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyNavBar(),
      appBar: AppBar(
        title: const Text('Plan wycieczki'),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('wycieczka'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  CustomPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
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
