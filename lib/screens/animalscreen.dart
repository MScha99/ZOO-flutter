import 'package:flutter/material.dart';
import 'package:zooapp/screens/animalphoto.dart';
import 'package:zooapp/widgets/sql_helper.dart';

class AnimalScreen extends StatelessWidget {
  const AnimalScreen({super.key});

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    final animal = ModalRoute.of(context)!.settings.arguments as Animal;

    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimalPhoto(),
                      settings: RouteSettings(
                        arguments: animal,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/images/animals/cat.jpg',
                    fit: BoxFit.cover,
                    width: 280.0,
                    height: 280.0,
                  ),
                ),
              ),
            ),
            const Text(
              'OPIS',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Text(
                animal.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimalPhoto(),
                          settings: RouteSettings(
                            arguments: animal,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/images/animals/cat.jpg',
                        fit: BoxFit.cover,
                        width: 140.0,
                        height: 140.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimalPhoto(),
                          settings: RouteSettings(
                            arguments: animal,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/images/animals/cat.jpg',
                        fit: BoxFit.cover,
                        width: 140.0,
                        height: 140.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimalPhoto(),
                          settings: RouteSettings(
                            arguments: animal,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/images/animals/cat.jpg',
                        fit: BoxFit.cover,
                        width: 140.0,
                        height: 140.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimalPhoto(),
                          settings: RouteSettings(
                            arguments: animal,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/images/animals/cat.jpg',
                        fit: BoxFit.cover,
                        width: 140.0,
                        height: 140.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
