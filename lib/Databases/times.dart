import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Times {

  Times({
    required this.hour,
    required this.sound,
    required this.sky
});

  final String hour;
  final String sound;
  final String sky;

  static const timesTable = """
    CREATE TABLE IF NOT EXISTS times(
      hour TEXT PRIMARY KEY,
      sound TEXT,
      sky TEXT);
  """;

  Map<String,dynamic> toMap(){
    return {
      "hour" : hour,
      "sound" :  sound,
      "sky" :  sky
    };
  }

  factory Times.fromMap(Map<String,dynamic> map ) =>
      Times(
          hour: map["hour"],
          sound: map["sound"],
          sky: map["sky"]
      );

  static createTimesTable() async {
    // A static method to create times table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(timesTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(timesTable));
    }
  }

  static insertTimeRow(Times time) async {
    // A static method to insert a time into times table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.insert("times", time.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
      db.insert("times", time.toMap());
    }
  }

  static Future<Times> retrieveTimes(String hour) async {
    // A static method to retrieve existing times in database

    getTimes(List<Map<String,dynamic>> rawTimes) {
      List<Times> times = [];

      for (Map<String,dynamic> time in rawTimes){
        Times current = Times.fromMap(time);
        times.add(current);
      }

      return times;

    }

    List<Map<String,dynamic>> rawTimes  = [];
    late Times time;

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      rawTimes = await db.query("times", where: "hour = ?", whereArgs: [hour]);
    } else {
      final Database db = await openDatabase("clock.db");
      rawTimes = await db.query("times", where: "hour = ?", whereArgs: [hour]);
    }

    time = Times.fromMap(rawTimes[0]);
    return time;
  }

}