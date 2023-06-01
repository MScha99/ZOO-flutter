import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_router/go_router.dart';

class AnimalGallery extends StatefulWidget {
  const AnimalGallery({super.key, required this.title});
  final String title;

  @override
  _AnimalGalleryState createState() => _AnimalGalleryState();
}

class _AnimalGalleryState extends State<AnimalGallery> {
  List<String>? imagePaths; // Nullable list

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final manifestMap =
          Map<String, dynamic>.from(jsonDecode(manifestContent));
      final List<String> imagePathList;
      if (widget.title == 'Twoje zdjęcia') {
        imagePathList = manifestMap.keys
            .where((String key) =>
                key.contains('assets/images/animals/user_photo'))
            .toList();
      } else {
        imagePathList = manifestMap.keys
            .where((String key) =>
                key.contains('assets/images/animals/app_photo_small'))
            .toList();
      }

      setState(() {
        imagePaths = imagePathList;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  List<String> extractDataFromAddress(String title, String path) {
    String filename = path.split('/').last;
    List<String> nameAndFlag = filename.split('.');
    if (title == 'Twoje zdjęcia') {
      nameAndFlag[1] = '0';
    } else {
      nameAndFlag = nameAndFlag[0].split(' ');
    }
    nameAndFlag[0] =
        nameAndFlag[0][0].toUpperCase() + nameAndFlag[0].substring(1);
    return nameAndFlag;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: imagePaths != null &&
              imagePaths!
                  .isNotEmpty // Check if imagePaths is not null and not empty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 140 / 140,
              ),
              itemCount: imagePaths!.length,
              itemBuilder: (context, index) {
                final imagePath = imagePaths![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      List<String> nameAndFlag =
                          extractDataFromAddress(widget.title, imagePath);
                      context.go(
                          "/home/animalgallery/photo?name=${nameAndFlag[0]}&photoFlag=${nameAndFlag[1]}");
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
            )
          : Center(
              child:
                  CircularProgressIndicator(), // Placeholder for loading indicator
            ),
    );
  }
}
