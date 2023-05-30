import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Balloons {

  Balloons({
    required this.npcID,
    required this.asset
});

  final String npcID;
  final String asset;

  static const balloonsTable = """
    CREATE TABLE IF NOT EXISTS balloons(
      npcID TEXT PRIMARY KEY,
      asset TEXT,
      FOREIGN KEY(npcID) REFERENCES npcs(name));
  """;

  Map<String,dynamic> toMap(){
    return {
      "npcID" : npcID,
      "asset" :  asset
    };
  }

  factory Balloons.fromMap(Map<String,dynamic> map) => Balloons(npcID: map["npcID"], asset: map["asset"]);

  static createTable() async {
    // A static method to create balloons table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(balloonsTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(balloonsTable));
    }
  }

  static insertRow(Balloons balloon) async {
    // A static method to insert a balloon row

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.insert("balloons", balloon.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
      db.insert("balloons", balloon.toMap());
    }
  }

  static retrieveCurrentNpcBalloon(String id) async {
    // A static method to retrieve a balloon from a given npcID

    List<Map<String,dynamic>> rawBalloon = [];

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      rawBalloon = await db.query("balloons", where: "npcID = ?", whereArgs: [id]);
    } else {
      final Database db = await openDatabase("clock.db");
      rawBalloon =  await db.query("balloons", where: "npcID = ?", whereArgs: [id]);
    }

    return Balloons.fromMap(rawBalloon[0]);
  }
}