import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Years {

  Years({
    required this.year
});

  final String year;

  static const yearsTable = """
    CREATE TABLE IF NOT EXISTS years(
      year TEXT PRIMARY KEY
    );
  """;

  Map<String,dynamic> toMap() {
    return {
      "year" :  year
    };
  }

  static createYearsTable() async {
    // A static method to create years table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(yearsTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(yearsTable));
    }
  }

  static insertYearRow(Years year) async {
    // A static method to insert a year in years table

    if (kIsWeb){
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase("clock.db");
      db.insert("years", year.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
      db.insert("years", year.toMap());
    }

  }

}