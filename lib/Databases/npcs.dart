import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Npcs {

  Npcs({
    required this.name,
    required this.picture
});

  final String name;
  final String picture;

  static const npcsTable = """
    CREATE TABLE IF NOT EXISTS npcs(
      name TEXT PRIMARY KEY,
      picture TEXT);
  """;

  factory Npcs.fromMap(Map<String,dynamic> map) => Npcs(
      name: map["name"],
      picture: map["picture"]);

  Map<String,dynamic> toMap(){
    return {
      "name" :  name,
      "picture" :  picture
    };
  }

  static createTable() async {
    // A static method to create npcs table
    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(npcsTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(npcsTable));
    }
  }

  static insertRow(Npcs npc) async {
    // A static method to insert a new npc into existing database
    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.insert("npcs", npc.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
      db.insert("npcs", npc.toMap());
    }
  }

  static Future<List<Npcs>> retrieveNpcs() async {
    // A static method to retrieve existing npcs in database

    getNpcs(List<Map<String,dynamic>> rawNpcs){
      // This method returns a list of Npcs instances
      List<Npcs> npcs  = [];

      for (Map<String,dynamic> npc in rawNpcs){
        Npcs current = Npcs.fromMap(npc);
        npcs.add(current);
      }
      return npcs;
    }

    List<Map<String,dynamic>> rawNpcs = [];
    List<Npcs> npcs = [];

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      rawNpcs = await db.query("npcs");
    } else {
      final Database db = await openDatabase("clock.db");
      rawNpcs = await db.query("npcs");
    }

    npcs = getNpcs(rawNpcs);
    return npcs;

  }

}