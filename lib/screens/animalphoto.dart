import 'package:flutter/material.dart';
import 'package:zooapp/widgets/sql_helper.dart';

class AnimalPhoto extends StatelessWidget {
  const AnimalPhoto({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final animal = ModalRoute.of(context)!.settings.arguments as Animal;

    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name + ' - zdjęcie'),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              'assets/images/animals/cat.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
