import 'package:flutter/material.dart';

String generatePath(String animalName, String photoFlag) {
  print(photoFlag);
  if (photoFlag == '0') {
    return "assets/images/animals/user_photo/${animalName.toLowerCase()}.jpg";
  }
  return "assets/images/animals/app_photo/${"${animalName.toLowerCase()} $photoFlag"}.jpg";
}

class AnimalPhoto extends StatelessWidget {
  const AnimalPhoto({Key? key, required this.name, required this.photoFlag})
      : super(key: key);
  final String name;
  final String photoFlag;

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
              generatePath(name, photoFlag),
            ),
          ),
        ),
      ),
    );
  }
}
