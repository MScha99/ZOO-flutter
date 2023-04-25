import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/screens/tourprogramscreen.dart';
import 'package:zooapp/screens/homescreen.dart';

import 'package:zooapp/widgets/custompageroute.dart';


final image = AssetImage('assets/images/map.jpg');

class MapMarker {
  final Offset position;
  final String name;

  MapMarker(this.position, this.name);
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final markers = [
    MapMarker(Offset(200, 180), 'Wejście/Wyjście'),
    MapMarker(Offset(370, 15), 'Żaba zielona'),
    MapMarker(Offset(20, 40), 'Krokodyl'),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTapUp: (details) => handleTap(details.localPosition),
          child: Stack(
            children: [
              Image(image: image),
              ...markers.map((marker) => Positioned(
                    left: marker.position.dx - 12,
                    top: marker.position.dy - 24,
                    child: IconButton(
                      icon: Icon(Icons.place),
                      onPressed: () => handleMarkerTap(marker),
                    ),
                  )),
            ],
          ),
        ),
      )
    );
  }


void handleTap(Offset position) {
    
  }

  void handleMarkerTap(MapMarker marker) {
    // Handle taps on a place marking
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(marker.name),
        content: Text('Tutaj znajduje się ${marker.name}.'),
      ),
    );
  }
}
