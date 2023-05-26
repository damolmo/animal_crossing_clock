import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DayMonthYearStation {
  
  DayMonthYearStation({
    required this.day,
    required this.month,
    required this.year,
    required this.station
});
  
  final String day;
  final String month;
  final String year;
  final String station;
  
  static const dayMonthYearStationTable = """
    CREATE TABLE IF NOT EXISTS dayMonthYearStations(
      id TEXT PRIMARY KEY,
      day TEXT,
      month TEXT,
      year TEXT,
      station TEXT,
      FOREIGN KEY(day) REFERENCES days(day),
      FOREIGN KEY(month) REFERENCES months(month),
      FOREIGN KEY(year) REFERENCES years(year),
      FOREIGN KEY(station) REFERENCES stations(name));
  """;
  
  Map<String,dynamic> toMap(){
    return {
      "day" :  day,
      "month" :  month,
      "year" :  year,
      "station" :  station
    };
  }

  factory DayMonthYearStation.fromMap(Map<String,dynamic> map) => DayMonthYearStation(
      day: map["day"],
      month: map["month"],
      year: map["year"],
      station: map["station"]);
  
  static createTable() async {
    // A static method to create a table
    
    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(dayMonthYearStationTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(dayMonthYearStationTable));
    }
  }
  
  static insertRow(DayMonthYearStation dayMonthYearStation) async {
    // A static method to insert a row
    
    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.insert("dayMonthYearStations", dayMonthYearStation.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
      db.insert("dayMonthYearStations", dayMonthYearStation.toMap());
    }
  }
  
  static Future<DayMonthYearStation> retrieveRow(String year, String month, String day) async {
    // A static method to retrieve a row which given values

    getDayMonthYearStation(List<Map<String,dynamic>> rawDayMonthYearStation) {
      List<DayMonthYearStation> dayMonthYearStation  = [];

      for (Map<String,dynamic> row in rawDayMonthYearStation){
        DayMonthYearStation current = DayMonthYearStation.fromMap(row);
        dayMonthYearStation.add(current);
      }

      return dayMonthYearStation;
    }
    
    List<Map<String,dynamic>> rawDayMonthYearStation = [];
    late DayMonthYearStation dayMonthYearStation;
    
    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      rawDayMonthYearStation = await db.query("dayMonthYearStations", where: "year = ? AND month = ? AND day = ?", whereArgs: [year, month, day]);
    } else {
      final Database db = await openDatabase("clock.db");
      rawDayMonthYearStation = await db.query("dayMonthYearStations", where: "year = ? AND month = ? AND day = ?", whereArgs: [year, month, day]);
    }

    dayMonthYearStation =  DayMonthYearStation.fromMap(rawDayMonthYearStation[0]);
    return dayMonthYearStation;
  }
  
  
  
}