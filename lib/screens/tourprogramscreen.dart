import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/screens/homescreen.dart';
import 'package:zooapp/widgets/sql_helper.dart';
import 'package:zooapp/widgets/custompageroute.dart';

class TourProgramScreen extends StatefulWidget {
  const TourProgramScreen({super.key});
  @override
  State<TourProgramScreen> createState() => _TourProgramScreenState();
}

class _TourProgramScreenState extends State<TourProgramScreen> {
  late Future<List<Map<String, dynamic>>> animalsCheck;
  late List<Map<String, dynamic>> animalsList;

  String? selectedAnimal;

  @override
  void initState() {
    super.initState();
    fetchAnimals();
    animalsCheck = SQLHelper.getAnimalsList();
  }

  Future<void> fetchAnimals() async {
    animalsList = await SQLHelper.getAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan wycieczki'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: animalsCheck,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final animals = snapshot.data!
                .map((map) => Animal(
                      id: map['id'],
                      name: map['name'],
                      description: map['description'],
                      visited: map['visited'],
                      onlist: map['onlist'],
                      photographed: map['photographed'],
                    ))
                .toList();

            return ListView.builder(
              itemCount: animals.length,
              prototypeItem: ListTile(
                title: Text(animals.first.name),
              ),
              itemBuilder: (context, index) {
                final animal = animals[index];
                return ListTile(
                  leading: Checkbox(
                    value: animal.visited == 0 ? false : true,
                    onChanged: (bool? value) async {
                      Feedback.forTap(context);
                      await SQLHelper.updateAnimalProperty(
                        animal.id,
                        'visited',
                        value != null && value ? 1 : 0,
                      );
                      setState(() {
                        animalsCheck = SQLHelper.getAnimalsList();
                      });
                    },
                  ),
                  trailing: GestureDetector(
                    onTap: () async {
                      await SQLHelper.updateAnimalProperty(
                        animal.id,
                        'onlist',
                        0,
                      );
                      setState(() {
                        animalsCheck = SQLHelper.getAnimalsList();
                      });
                    },
                    child: const Icon(Icons.delete),
                  ),
                  title: Text(animal.name),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data.'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      ////////////////////////////////////////
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Zwierzak'),
            content: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return animalsList
                    .where((animal) => animal["name"]
                        .toString()
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                    .map((animal) => animal["name"].toString());
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
                setState(() {
                  selectedAnimal = selection;
                });
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Anuluj'),
                child: const Text('Anuluj'),
              ),
              TextButton(
                onPressed: () async => {
                  Navigator.pop(context, 'Dodaj'),
                  await SQLHelper.updateAnimalProperty(
                    animalsList.firstWhere(
                        (animal) => animal['name'] == selectedAnimal)['id'],
                    'onlist',
                    1,
                  ),
                  setState(() {
                    animalsCheck = SQLHelper.getAnimalsList();
                  }),
                },
                child: const Text('Dodaj'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
