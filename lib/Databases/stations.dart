import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Stations {

  Stations({
    required this.name,
    required this.path,
    required this.tree
});

  final String name;
  final String path;
  final String tree;

  static const stationsTable = """
    CREATE TABLE IF NOT EXISTS stations(
      name TEXT PRIMARY KEY,
      path TEXT,
      tree TEXT
    );
  """;

  Map<String,dynamic> toMap(){
    return {
      "name" : name,
      "path" : path,
      "tree" :  tree
    };
  }

  factory Stations.fromMap(Map<String,dynamic> map) => Stations(
      name: map["name"],
      path: map["path"],
      tree: map["tree"]);

  static createStationsTable() async {
    // A static method to create stations table
    // Uses defined SQL string

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(stationsTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(stationsTable));
    }
  }

  static insertStation(Stations station) async {
    // A static method to insert a new station in stations table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.insert("stations", station.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
      db.insert("stations", station.toMap());
    }
  }

  static Future<Stations> retrieveStations(String station) async {
    // A static method to retrieve existing stations

    List<Map<String,dynamic>> rawStations = [];
    late Stations currentStation;

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      rawStations = await db.query("stations", where: "name = ?", whereArgs: [station]);
    } else {
      final Database db = await openDatabase("clock.db");
      rawStations = await db.query("stations", where: "name = ?", whereArgs: [station]);
    }

    currentStation = Stations.fromMap(rawStations[0]);
    return currentStation;
  }

}