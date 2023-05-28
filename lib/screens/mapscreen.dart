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
    MapMarker(Offset(1370, 115), 'Żaba zielona'),
    MapMarker(Offset(1900, 1040), 'Krokodyl'),
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
                      icon: Icon(Icons.place, color: Colors.red , size: 100.0,),
                      onPressed: () => handleMarkerTap(marker),
                    )
                ))
              ],
            )
          )
        ],
      ),
    );
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