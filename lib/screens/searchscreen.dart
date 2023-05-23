import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/widgets/sql_helper.dart';
import 'package:zooapp/screens/animalscreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Map<String, dynamic>>> animalsList;

  @override
  void initState() {
    super.initState();
    animalsList = SQLHelper.getAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista zwierzaków'),
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _animalsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final animals = snapshot.data!.map((map) => Animal(
                  id: map['id'],
                  name: map['name'],
                  description: map['description'],
                  visited: map['visited'],
                  onlist: map['onlist'],
                  photographed: map['photographed'],
                ));
            return ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals.elementAt(index);
                return ListTile(
                  title: Text(animal.name),
                  subtitle: Text(animal.description),
                  leading: Icon(Icons.pets),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimalScreen(),
                        settings: RouteSettings(
                          arguments: animal,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

