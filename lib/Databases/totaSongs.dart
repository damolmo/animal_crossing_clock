import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

class TotaSongs {

  TotaSongs({
    required this.songName,
    required this.songBoxart,
    required this.songPath
});

  final String songName;
  final String songBoxart;
  final String songPath;

  static const songsTable = """
    CREATE TABLE IF NOT EXISTS songs(
      songName TEXT PRIMARY KEY,
      songBoxart TEXT,
      songPath TEXT
    );
  """;

  Map<String,dynamic> toMap() => {"songName" : songName, "songBoxart" : songBoxart, "songPath" : songPath};
  factory TotaSongs.fromMap(Map<String,dynamic> map) =>
    TotaSongs(songName: map["songName"], songBoxart: map["songBoxart"], songPath: map["songPath"]);

  static createSongTable() async {
    // A static method that allow us to create the songs table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("clock.db");
      db.transaction((txn) => txn.execute(songsTable));
    } else {
      final Database db = await openDatabase("clock.db");
      db.transaction((txn) => txn.execute(songsTable));
    }
  }

  static insertSongIntoTable(TotaSongs song) async {
    // A static method that allow us to insert a song
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("clock.db");
      db.insert("songs", song.toMap());
    } else {
      final Database db = await openDatabase("clock.db");
      db.insert("songs", song.toMap());
    }
  }

  static rawSongToInstance(List<Map<String,dynamic>> rawSongs, List<TotaSongs> songs) {
    for (Map<String,dynamic> rawSong in rawSongs){
      songs.add(TotaSongs.fromMap(rawSong));
    }

    return songs;
  }

  static Future<List<TotaSongs>> retrieveCurrentSongs() async {
    // A static method that retrieves all existing songs on database
    List<TotaSongs> songs = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("clock.db");
      songs = rawSongToInstance(await db.query("songs"), songs);
    } else {
      final Database db = await openDatabase("clock.db");
      songs = rawSongToInstance(await db.query("songs"), songs);
    }

    return songs;
  }


}