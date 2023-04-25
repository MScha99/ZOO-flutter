import 'dart:async';

import 'package:sqflite/sqflite.dart' as sql;

class Animal {
  final int id;
  final String name;
  final String description;
  final int visited;
  final int photographed;

  const Animal({
    required this.id,
    required this.name,
    required this.description,
    required this.visited,
    required this.photographed,
  });
}

class SQLHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase('zoo_database.db', version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE animals (id INTEGER PRIMARY KEY, name TEXT, description TEXT, visited INTEGER DEFAULT 0, photographed INTEGER DEFAULT 0)');
      await db.insert('animals', {
        'name': 'Zebra stepowa',
        'description':
            'gatunek ssaka z rodziny koniowatych, najliczniejszy gatunek zebry. Często spotykany w ogrodach zoologicznych, również w Polsce. Jest uznawany za bliski zagrożenia wyginięciem.',
      });
      await db.insert('animals', {
        'name': 'Słoń afrykański',
        'description':
            'Słoń afrykański to największe lądowe zwierzę na Ziemi. Spotykane są na sawannach, w lasach i na pustyniach w Afryce.',
      });
      await db.insert('animals', {
        'name': 'Żyrafa',
        'description':
            'Żyrafa jest najwyższym lądowym zwierzęciem na Ziemi. Ma długie szyje i nogi, i występuje na sawannach i w lasach Afryki.',
      });
      await db.insert('animals', {
        'name': 'Lew',
        'description':
            'Lew to duży drapieżnik z rodziny kotowatych, występujący na sawannach i w lasach Afryki. Uważany jest za króla dzikich zwierząt.',
      });
      await db.insert('animals', {
        'name': 'Niedźwiedź polarny',
        'description':
            'Niedźwiedź polarny to duże drapieżne ssaki, żyjące w Arktyce. Mają biały futro i dobrze przystosowane do życia w zimnych warunkach.',
      });
      await db.insert('animals', {
        'name': 'Pingwin cesarski',
        'description':
            'Pingwin cesarski to gatunek pingwina zamieszkujący Antarktydę. Mają charakterystyczny biało-czarny wygląd i potrafią nurkować na dużą głębokość.',
      });
    });
  }

  // // A method that retrieves all animals from animals table.
  // Future<List<Animal>> animals() async {
  //   // Get a reference to the database.
  //   final db = await SQLHelper.db();

  //   // Query the table for all animals.
  //   final List<Map<String, dynamic>> maps = await db.query('animals');

  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return List.generate(maps.length, (i) {
  //     return Animal(
  //       id: maps[i]['id'],
  //       name: maps[i]['name'],
  //       description: maps[i]['description'],
  //       visited: maps[i]['visited'],
  //       photographed: maps[i]['photographed'],
  //     );
  //   });
  // }

  static Future<List<Map<String, dynamic>>> getAnimals() async {
    final db = await SQLHelper.db();
    return db.query('animals', orderBy: "id");
  }
}
