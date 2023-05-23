import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/widgets/sql_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Map<String, dynamic>>> animalsList;

  @override
  void initState() {
    super.initState();
    // fetchAnimals();
    animalsList = SQLHelper.getAnimalsList();
  }

  // Future<void> fetchAnimals() async {
  //   animalsList = await SQLHelper.getAnimals();
  // }

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
                    return ListView.separated(
                        separatorBuilder: (context, index) =>
                            const Divider(), // Add Divider widget
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: ConstrainedBox(
                              constraints: BoxConstraints(
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
                            title: Text(
                              snapshot.data![index]["name"],
                            ),
                            subtitle: Text(
                              snapshot.data![index]["description"],
                            ),
                            onTap: () {
                              context.push("/animal");
                            },
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          )
          // Expanded(
          //    child: ListView.builder(
          //     itemCount: 10,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           print("tapped");
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Container(
          //             color: Colors.grey,
          //             height: 100.0,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
