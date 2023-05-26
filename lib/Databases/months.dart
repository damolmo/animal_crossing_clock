import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Months {

  Months({
    required this.month,
    required this.station
});

  final String month;
  final String station;

  static const monthsTable = """
    CREATE TABLE IF NOT EXISTS months(
      month TEXT PRIMARY KEY,
      station TEXT,
      FOREIGN KEY(station) REFERENCES stations(name));
  """;

  Map<String,dynamic> toMap(){
    return {
      "month" :  month,
      "station" : station
    };
  }

  factory Months.fromMap(Map<String,dynamic> map) => Months(
      month: map["month"],
      station: map["station"]);

  static createMonthsTable() async {
    // A static method to create months table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(monthsTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(monthsTable));
    }
  }

  static insertMonthRow(Months month) async {
    // A static method to insert a row into months table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.insert("months", month.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
      db.insert("months", month.toMap());
    }
  }

  static Future<List<Months>> retrieveMonth(String month) async {
    // A method to retrieve month row with given month string

    getMonths(List<Map<String,dynamic>> rawMonths) {
      List<Months> months = [];

      for (Map<String,dynamic> month in rawMonths){
        Months current = Months.fromMap(month);
        months.add(current);
      }

      return months;

    }

    List<Map<String,dynamic>> rawMonths = [];
    List<Months> months = [];

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      rawMonths = await db.query("months", where: "month = ?", whereArgs: [month]);
    } else {
      final Database db = await openDatabase("clock.db");
      rawMonths = await db.query("months", where: "month = ?", whereArgs: [month]);
    }

    months = getMonths(rawMonths);
    return months;
  }


}