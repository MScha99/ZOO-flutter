import 'package:flutter/material.dart';
import 'package:zooapp/widgets/sql_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Map<String, dynamic>>> _animalsFuture;

  @override
  void initState() {
    super.initState();
    _animalsFuture = SQLHelper.getAnimals();
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
