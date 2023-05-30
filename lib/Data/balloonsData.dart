import '../exports.dart';

class BalloonsData {

  static Map<String,dynamic> balloonsMap = {

    "Globo aldeano" : {
      "npcID" :  "aldeano",
      "asset" :  "assets/balloons/red_balloon.png"
    },

    "Globo Tota" : {
      "npcID" :  "totakeke",
      "asset" :  "assets/balloons/blue_balloon.png"
    },

    "Globo Tendo y Nendo" : {
      "npcID" :  "tendo_nendo",
      "asset"  : "assets/balloons/green_balloon.png"
    },

    "Globo Canela" : {
      "npcID" :  "canela",
      "asset" :  "assets/balloons/yellow_balloon.png"
    }
  };

  static insertNpcData() async {
    // A static method to insert a balloon on balloons table

    Balloons.createTable();

    for (String balloon in balloonsMap.keys){
      Balloons current = Balloons(
          npcID: balloonsMap[balloon]["npcID"],
          asset: balloonsMap[balloon]["asset"]);
      Balloons.insertRow(current);
    }
  }


}