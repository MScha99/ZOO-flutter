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
  late List<Map<String, dynamic>> animalsSearch;

  @override
  void initState() {
    super.initState();
    animalsList = SQLHelper.getAnimals();
    searchFetch();
  }

  Future<void> searchFetch() async {
    animalsSearch = await SQLHelper.getAnimals();
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
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return animalsSearch
                        .where((animal) => animal["name"]
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                        .map((animal) => animal["name"].toString());
                  },
                  onSelected: (String selection) {
                    context.push("/animal?name=$selection");

                    // You can perform any actions with the selected value here
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Nazwa zwierzaka",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12.0),
                        suffixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (String value) {
                        // You can perform any actions when the text input changes here
                      },
                      onSubmitted: (String value) {
                        onFieldSubmitted();
                      },
                    );
                  },
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
                    print(animals.length);

                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: animals.length,
                      itemBuilder: (context, index) {
                        final animal = animals[index];
                        return ListTile(
                          leading: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60,
                              maxWidth: 60,
                              minHeight: 60,
                              maxHeight: 60,
                            ),
                            child: Image.asset(
                              "lib/assets/images/catSquare.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(animal.name),
                          subtitle: Text(animal.description),
                          onTap: () {
                            context.push("/animal?name=${animal.name}");
                          },
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
            ),
          ),
        ],
      ),
    );
  }
}
