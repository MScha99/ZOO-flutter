import 'package:flutter/material.dart';

class AnimalPhoto extends StatelessWidget {
  const AnimalPhoto({Key? key, required this.name}) : super(key: key);
  final String name;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name - zdjęcie'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              "assets/images/animals/user_photo/${name.toLowerCase()}.jpg",
            ),
          ),
        ),
      ),
    );
  }
}
