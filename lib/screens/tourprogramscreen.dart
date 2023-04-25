import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/screens/homescreen.dart';
import 'package:zooapp/widgets/sql_helper.dart';
import 'package:zooapp/widgets/custompageroute.dart';

class TourProgramScreen extends StatelessWidget {
  const TourProgramScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                context.push('/home/testowa');
              },
              child: const Text('do home/testowa'),
            ),
          ],
        ),
      ),
    );
  }
}
