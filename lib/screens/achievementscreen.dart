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
  // This widget is the root of your application.

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

  //int achievedCount = achievements.where((achievement) => achievement.achieved).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Osiągnięcia'),
      ),
      // bottomNavigationBar: const BottomNavBar(),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: animalsCheck,
          builder: (context, snapshot) {
            double progress (){
              double p = 0;
              for (var i = 0; i < snapshot.data!.length; i++) {
                snapshot.data![i]["photographed"] == 1 ? p++ : p;
              }
              return p;
            }
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Container(
                    height: 16.0, // Grubość paska postępu
                    margin: EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3), // Kolor paska postępu
                      borderRadius: BorderRadius.circular(8.0), // Zaokrąglenie rogów
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 238, 177, 102), // Kolor wypełnienia postępu
                          borderRadius: BorderRadius.circular(8.0), // Zaokrąglenie rogów wypełnienia
                        ),
                      ),
                    ),
                  ),
          
                  Expanded( 
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      prototypeItem: ListTile(
                        title: Text(snapshot.data!.first["name"]),
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index]["name"]),
                          subtitle: Text(snapshot.data![index]["achievement_des"]),
                          trailing: Icon(snapshot.data![index]["photographed"] == 1 ? Icons.check_circle : Icons.radio_button_unchecked, color: snapshot.data![index]["photographed"] == 1 ? Color.fromARGB(255, 238, 177, 102) : Colors.grey),
                        );
                      },
                    ),
                  ),
                ],
               );
            }else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
    );
  }
}