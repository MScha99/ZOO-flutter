import 'dart:async';

import 'package:sqflite/sqflite.dart' as sql;

class Animal {
  final int id;
  final String name;
  final String description;
  final int visited;
  final int onlist;
  final int photographed;
  //final String achievementDes;

  const Animal({
    required this.id,
    required this.name,
    required this.description,
    required this.onlist,
    required this.visited,
    required this.photographed,
    //required this.achievementDes,
  });
}

class SQLHelper {
  static Future<sql.Database> db() async {
    //await deleteDatabase();
    return sql.openDatabase('zoo_database.db', version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE animals (id INTEGER PRIMARY KEY, name TEXT, description TEXT, achievement_des TEXT, visited INTEGER DEFAULT 0, onlist INTEGER DEFAULT 0, photographed INTEGER DEFAULT 0, continent TEXT)');
      await db.insert('animals', {
        'name': 'Zebra stepowa',
        'description':
            'Gatunek ssaka z rodziny koniowatych, najliczniejszy gatunek zebry. Często spotykany w ogrodach zoologicznych, również w Polsce. Jest uznawany za bliski zagrożenia wyginięciem.',
        'achievement_des': 'Zrobiono zdjęcie z zebrą stepową',
        'continent': 'Africa'
      });
      await db.insert('animals', {
        'name': 'Słoń afrykański',
        'description':
            'Słoń afrykański to największe lądowe zwierzę na Ziemi. Spotykane są na sawannach, w lasach i na pustyniach w Afryce.',
        'achievement_des': 'Zrobiono zdjęcie ze słoniem afrykańskim',
        'continent': 'Africa'
      });
      await db.insert('animals', {
        'name': 'Żyrafa',
        'description':
            'Żyrafa jest najwyższym lądowym zwierzęciem na Ziemi. Ma długie szyje i nogi, i występuje na sawannach i w lasach Afryki.',
        'achievement_des': 'Zrobiono zdjęcie z żyrafą',
        'onlist': 1,
        'continent': 'Africa'
      });
      await db.insert('animals', {
        'name': 'Lew',
        'description':
            'Lew to duży drapieżnik z rodziny kotowatych, występujący na sawannach i w lasach Afryki. Uważany jest za króla dzikich zwierząt.',
        'achievement_des': 'Zrobiono zdjęcie z lwem',
        'continent': 'Africa'
      });
      await db.insert('animals', {
        'name': 'Niedźwiedź polarny',
        'description':
            'Niedźwiedź polarny to duże drapieżne ssaki, żyjące w Arktyce. Mają biały futro i dobrze przystosowane do życia w zimnych warunkach.',
        'achievement_des': 'Zrobiono zdjęcie z niedźwiedziem polarnym',
        'continent': 'Antarctica'
      });
      await db.insert('animals', {
        'name': 'Pingwin cesarski',
        'description':
            'Pingwin cesarski to gatunek pingwina zamieszkujący Antarktydę. Mają charakterystyczny biało-czarny wygląd i potrafią nurkować na dużą głębokość.',
        'achievement_des': 'Zrobiono zdjęcie z pingwinem cesarskim',
        'continent': 'Antarctica'
      });
    });
  }

  static Future<void> deleteDatabase() async {
    await sql.deleteDatabase('zoo_database.db');
  }

  static Future<List<Map<String, dynamic>>> getAnimals() async {
    // await deleteDatabase();
    final db = await SQLHelper.db();
    return db.query('animals', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getAnimal(String name) async {
    // await deleteDatabase();
    final db = await SQLHelper.db();
    return db.query('animals',
        where: "name = ?", whereArgs: [name], orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getAnimalsList() async {
    // await deleteDatabase();
    final db = await SQLHelper.db();
    return db
        .rawQuery('SELECT * FROM animals WHERE "onlist"=1 ORDER BY "name"');
  }

  static Future<void> updateAnimalProperty(
      int id, String property, dynamic value) async {
    final db = await SQLHelper.db();
    await db.update('animals', {property: value},
        where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> updateAnimalPropertyByName(
      String name, String property, dynamic value) async {
    final db = await SQLHelper.db();
    await db.update('animals', {property: value},
        where: 'name = ?', whereArgs: [name]);
  }

//   static Future<List<Map<String, dynamic>>> getProgram() async {
//     final db = await SQLHelper.db();
//     final List<Map<String, dynamic>> maps =
//         await db.rawQuery('SELECT * FROM animals ORDER BY "animals"');
//     return List.generate(maps.length, (i) {
// return Animal(
//   name: maps[i]['name'],
//   visited: maps[i]['visited'],
//  );
//     });

//   }
}
