import 'package:flutter/material.dart';

class TestowaScreen extends StatelessWidget {
  const TestowaScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Strona testowa'),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('testowa pod adresem /home/testowa'),
          ],
        ),
      ),
    );
  }
}
