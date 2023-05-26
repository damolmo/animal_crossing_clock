import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Days {

  Days({
    required this.day
});

  final String day;

  static const daysTable = """
    CREATE TABLE IF NOT EXISTS days(
      day TEXT PRIMARY KEY
    );
  """;

  Map<String,dynamic> toMap() {
    return {
      "day" : day
    };
  }

  static createDaysTable() async {
    // A static method to create days table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(daysTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(daysTable));
    }
  }

  static insertDayRow(Days day) async {
    // A static method to insert a day in days table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.insert("days", day.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
    db.insert("days", day.toMap());
    }
  }
}