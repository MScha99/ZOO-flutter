import 'package:flutter/material.dart';
import 'package:zooapp/widgets/sql_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/screens/tourprogramscreen.dart';
import 'package:zooapp/screens/homescreen.dart';

import 'package:zooapp/widgets/custompageroute.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
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
        title: const Text('Osiągnięcia'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
            double progress() {
              double progressValue = 0.0;
              for (int i = 0; i < animals.length; i++) {
                snapshot.data![i]["photographed"] == 1
                    ? progressValue++
                    : progressValue;
              }
              return progressValue / animals.length;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 16.0, // Grubość paska postępu
                  margin:
                      EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3), // Kolor paska postępu
                    borderRadius:
                        BorderRadius.circular(8.0), // Zaokrąglenie rogów
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 238, 177, 102), // Kolor wypełnienia postępu
                        borderRadius: BorderRadius.circular(
                            8.0), // Zaokrąglenie rogów wypełnienia
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: animals.length,
                    prototypeItem: ListTile(
                      title: Text(snapshot.data!.first["name"]),
                    ),
                    itemBuilder: (context, index) {
                      final animal = animals[index];
                      return ListTile(
                        title: Text(animal.name),
                        subtitle: Text(
                            "Placeholder achievement description"), //animal.achievement_des
                        trailing: Icon(
                            snapshot.data![index]["photographed"] == 1
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: snapshot.data![index]["photographed"] == 1
                                ? Color.fromARGB(255, 238, 177, 102)
                                : Colors.grey),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
