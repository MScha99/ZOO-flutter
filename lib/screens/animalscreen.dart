import 'package:flutter/material.dart';

class AnimalScreen extends StatefulWidget {
  String? name;
  AnimalScreen({super.key, this.name});

  @override
  State<AnimalScreen> createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  late String name;

  @override
  void initState() {
    super.initState();
    name = "pingwin";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
    );
  }
}
