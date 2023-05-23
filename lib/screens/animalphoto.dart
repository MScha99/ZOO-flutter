import 'package:flutter/material.dart';
import 'package:zooapp/widgets/sql_helper.dart';

class AnimalPhoto extends StatelessWidget {
  AnimalPhoto({Key? key, required this.name}) : super(key: key);
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
