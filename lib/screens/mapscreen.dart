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
    MapMarker(Offset(2000, 1900), 'Wejście/Wyjście'),
    MapMarker(Offset(1370, 115), 'Zebra stepowa'),
    MapMarker(Offset(3000, 1040), 'Słoń afrykański'),
    MapMarker(Offset(2200, 1240), 'Żyrafa'),
    MapMarker(Offset(1200, 840), 'Lew'),
    MapMarker(Offset(3500, 1740), 'Niedźwiedź polarny'),
    MapMarker(Offset(800, 1750), 'Pingwin cesarski'),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: Stack(
        children: [
          InteractiveViewer(
              minScale: 0.1,
              maxScale: 0.8,
              constrained: false,
              boundaryMargin: EdgeInsets.all(75),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/map.jpg',
                  ),
                  ...markers.map((marker) => Positioned(
                      left: marker.position.dx - 12,
                      top: marker.position.dy - 24,
                      child: IconButton(
                        icon: Icon(
                          Icons.place,
                          color: Colors.red,
                          size: 100.0,
                        ),
                        onPressed: () => handleMarkerTap(marker),
                      )))
                ],
              ))
        ],
      ),
    );
  }

  void handleMarkerTap(MapMarker marker) {
    // Handle taps on a place marking
    if (marker.name != 'Wejście/Wyjście') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(marker.name),
          content: Text('Tutaj znajduje się ${marker.name}.'),
          actions: [
            ElevatedButton(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 131, 82, 64),
              ),
              onPressed: () {
                context.push("/animal?name=${marker.name}");
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(marker.name),
          content: Text('Tutaj znajduje się ${marker.name}.'),
        ),
      );
    }
  }
}
