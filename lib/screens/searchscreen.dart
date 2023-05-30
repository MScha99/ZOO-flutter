import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/widgets/sql_helper.dart';

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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: InkWell(
              onTap: () {
                print("tapped");
              },
              child: Container(
                alignment: Alignment.center,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Nazwa zwierzaka",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: animalsList,
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
                              //achievementDes: map['achievement_des'],
                            ))
                        .toList();
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: animals.length,
                      itemBuilder: (context, index) {
                        final animal = animals[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              "assets/images/animals/${"${animal.name.toLowerCase()} ${1}"}.jpg",
                              fit: BoxFit.cover,
                              width: 100.0,
                              height: 80.0,
                            ),
                          ),
                          title: Text(animal.name),
                          //subtitle: Text(animal.description),
                          onTap: () {
                            context.push("/search/animal?name=${animal.name}");
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading data.'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
