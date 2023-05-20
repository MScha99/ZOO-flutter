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
  late Future<List<Map<String, dynamic>>> _program;

  List<Map> animalsCheck = [
    {"name": "Słoń", "isChecked": false},
    {"name": "Zyrafa", "isChecked": true}
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final database = SQLHelper();
    // final program = database.getProgram();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan wycieczki'),
      ),
      body: ListView.builder(
        itemCount: animalsCheck.length,
        prototypeItem: ListTile(
          title: Text(animalsCheck.first["name"]),
        ),
        itemBuilder: (context, index) {
          return ListTile(
              leading: Checkbox(
                value: animalsCheck[index]["isChecked"],
                onChanged: (bool? value) {
                  setState(() {
                    animalsCheck[index]["isChecked"] = value ?? false;
                  });
                },
              ),
              trailing: const Icon(Icons.delete),
              title: Text(animalsCheck[index]["name"]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('AlertDialog Title'),
            content: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return animalsCheck
                    .where((animal) => animal["name"]
                        .toString()
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                    .map((animal) => animal["name"].toString());
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
                setState(() {
                  animalsCheck.add({"name": selection, "isChecked": false});
                });
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
