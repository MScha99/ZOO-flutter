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

            
              bool Asia = false;
              bool Africa = false;
              bool Europe = false;
              bool NorthAmerica = false;
              bool SouthAmerica = false;
              bool Australia = false;
              bool Antarctica = false;
               
              int Asianum = 0;
              int Africanum = 0;
              int Europenum = 0;
              int NorthAmericanum = 0;
              int SouthAmericanum = 0;
              int Australianum = 0;
              int Antarcticanum = 0;

              int Asiaall = 0;
              int Africaall = 0;
              int Europeall = 0;
              int NorthAmericaall = 0;
              int SouthAmericaall = 0;
              int Australiaall = 0;
              int Antarcticaall = 0;
            
              for (int i = 0; i < animals.length; i++) {
                if (snapshot.data![i]["continent"] == "Asia"){
                  Asiaall++;
                  if (snapshot.data![i]["photographed"] == 1){Asianum++;}}

                if (snapshot.data![i]["continent"] == "Africa"){
                  Africaall++;
                  if (snapshot.data![i]["photographed"] == 1){Africanum++;}}

                if (snapshot.data![i]["continent"] == "Europe"){
                  Europeall++;
                  if (snapshot.data![i]["photographed"] == 1){Europenum++;}}

                if (snapshot.data![i]["continent"] == "NorthAmerica"){
                  NorthAmericaall++;
                  if (snapshot.data![i]["photographed"] == 1){NorthAmericanum++;}}

                if (snapshot.data![i]["continent"] == "SouthAmericanum"){
                  SouthAmericaall++;
                  if (snapshot.data![i]["photographed"] == 1){SouthAmericanum++;}}

                if (snapshot.data![i]["continent"] == "Australia"){
                  Australiaall++;
                  if (snapshot.data![i]["photographed"] == 1){Australianum++;}}

                if (snapshot.data![i]["continent"] == "Antarctica"){
                  Antarcticaall++;
                  if (snapshot.data![i]["photographed"] == 1){Antarcticanum++;}}
                }
                
              Africaall != 0 && Africanum == Africaall ? Africa = true : Africa = false;
              Antarcticaall != 0 && Antarcticanum == Antarcticaall ? Antarctica = true : Antarctica = false;

            double progress() {
              double progressValue = 0.0;
              for (int i = 0; i < animals.length; i++) {
                snapshot.data![i]["photographed"] == 1
                    ? progressValue++
                    : progressValue;
              }
              Asia == true ? progressValue++ : progressValue;
              Africa == true ? progressValue++ : progressValue;
              Europe == true ? progressValue++ : progressValue;
              NorthAmerica == true ? progressValue++ : progressValue;
              SouthAmerica == true ? progressValue++ : progressValue;
              Australia == true ? progressValue++ : progressValue;
              Antarctica == true ? progressValue++ : progressValue;
              return progressValue / (animals.length + 7);
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
                    itemCount: animals.length+7,
                    itemBuilder: (context, index) {
                      
                      if (index < animals.length) {
                      final animal = animals[index];
                      return  ListTile(
                        title: Text(animal.name),
                        subtitle: Text(
                            "Zrób zdjęcie ze zwierzakiem"), //animal.achievement_des
                        trailing: Icon(
                            snapshot.data![index]["photographed"] == 1
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: snapshot.data![index]["photographed"] == 1
                                ? Color.fromARGB(255, 238, 177, 102)
                                : Colors.grey),
                      );
                      }else if (index == animals.length) {
                        return ListTile(
                              title: Text("Zwierzęta Azji"),
                              subtitle: Text(
                                  "Zrób zdjęcie ze wszystkimi zwierzakami pochodzącymi z Azji"),
                              trailing: Icon(
                                Africa == true
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: Africa == true
                                    ? Color.fromARGB(255, 238, 177, 102)
                                    : Colors.grey),
                              isThreeLine: true,
                        );
                      }else if (index == animals.length + 1) {
                        return ListTile(
                          title: Text("Zwierzęta Afryki"),
                          subtitle: Text(
                              "Zrób zdjęcie ze wszystkimi zwierzakami pochodzącymi z Afryki"),
                          trailing: Icon(
                             Africa == true
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: Africa == true
                                 ? Color.fromARGB(255, 238, 177, 102)
                                 : Colors.grey),
                          isThreeLine: true,
                        );
                      }else if (index == animals.length + 2) {
                        return ListTile(
                          title: Text("Zwierzęta Europy"),
                          subtitle: Text(
                              "Zrób zdjęcie ze wszystkimi zwierzakami pochodzącymi z Europy"),
                          trailing: Icon(
                             Africa == true
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: Africa == true
                                 ? Color.fromARGB(255, 238, 177, 102)
                                 : Colors.grey),
                            isThreeLine: true,
                        );
                      }else if (index == animals.length + 3) {
                        return ListTile(
                          title: Text("Zwierzęta Ameryki Północnej"),
                          subtitle: Text(
                              "Zrób zdjęcie ze wszystkimi zwierzakami pochodzącymi z Ameryki Północnej"),
                          trailing: Icon(
                             Africa == true
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: Africa == true
                                 ? Color.fromARGB(255, 238, 177, 102)
                                 : Colors.grey),
                                 isThreeLine: true,
                        );
                      }else if (index == animals.length + 4) {
                        return ListTile(
                          title: Text("Zwierzęta Ameryki Południowej"),
                          subtitle: Text(
                              "Zrób zdjęcie ze wszystkimi zwierzakami pochodzącymi z Ameryki Południowej"),
                          trailing: Icon(
                             Africa == true
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: Africa == true
                                 ? Color.fromARGB(255, 238, 177, 102)
                                 : Colors.grey),
                                 isThreeLine: true,
                        );
                      }else if (index == animals.length + 5) {
                        return ListTile(
                          title: Text("Zwierzęta Australji"),
                          subtitle: Text(
                              "Zrób zdjęcie ze wszystkimi zwierzakami pochodzącymi z Australji"),
                          trailing: Icon(
                             Africa == true
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: Africa == true
                                 ? Color.fromARGB(255, 238, 177, 102)
                                 : Colors.grey),
                                 isThreeLine: true,

                        );
                      }else if (index == animals.length + 6) {
                        return ListTile(
                          title: Text("Zwierzęta Arktyki i Antarktydy"),
                          subtitle: Text(
                              "Zrób zdjęcie ze wszystkimi zwierzakami pochodzącymi z Arktyki i Antarktydy"),
                          trailing: Icon(
                             Antarctica == true
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: Antarctica == true
                                 ? Color.fromARGB(255, 238, 177, 102)
                                 : Colors.grey),
                                 isThreeLine: true,
                        );
                      }
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
