import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/screens/camerapage.dart';
import 'package:zooapp/widgets/sql_helper.dart';

TextStyle greyboxStyle = const TextStyle(
  color: Colors.black,
  fontSize: 14,
);

Widget isPhotographed(var photographed, BuildContext context,
    AnimalScreen widget, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
  if (photographed == 1) {
    return GestureDetector(
      onTap: () {
        context.go("/search/animal/photo?name=${widget.name}&photoFlag=${"0"}");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(
          "assets/images/animals/user_photo/${widget.name.toLowerCase()}.jpg",
          fit: BoxFit.cover,
          width: 280.0,
          height: 280.0,
        ),
      ),
    );
  }
  return GestureDetector(
    onTap: () async {
      await availableCameras().then(
        (value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CameraPage(
              camera: value.first,
              animalName: widget.name.toLowerCase(),
            ),
          ),
        ),
      );
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        color: const Color.fromARGB(255, 217, 217, 217),
        width: 280,
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Miejsce na Twoje zdjęcie',
              style: greyboxStyle,
            ),
            const Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 71, 71, 71),
              size: 126,
            ),
            Text(
              'Kliknij tutaj, aby je dodać',
              style: greyboxStyle,
            ),
          ],
        ),
      ),
    ),
  );
}

class AnimalScreen extends StatefulWidget {
  const AnimalScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<AnimalScreen> createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  late Future<List<Map<String, dynamic>>> animalDetails;
  @override
  void initState() {
    super.initState();
    animalDetails = SQLHelper.getAnimal(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: animalDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
                      child: isPhotographed(snapshot.data![0]['photographed'],
                          context, widget, snapshot),
                    ),
                    const Text(
                      'OPIS',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                      child: Text(
                        snapshot.data![0]['description'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      child: SizedBox(
                        height: 400.0,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 140 / 140,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final imagePath =
                                "assets/images/animals/app_photo/${"${widget.name.toLowerCase()} ${index + 1}"}.jpg";
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  context.go(
                                      "/search/animal/photo?name=${widget.name}&photoFlag=${index + 1}");
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
