import '../exports.dart';

class NpcsData {

  static Map<String,dynamic> npcsMap = {

    "aldeano" : {
      "picture" :  "assets/npcs/aldeano.png"
    },

    "totakeke" :  {
      "picture" :  "assets/npcs/totakeke.png"
    },

    "tendo_nendo" :  {
      "picture" :  "assets/npcs/tendo_nendo.png"
    },

    "canela" : {
      "picture" : "assets/npcs/canela.png"
    }
  };

  static insertNpcsData() async {
    // A static method to insert npcs data into npcs table

    Npcs.createTable();

    for (String npc in npcsMap.keys){
      Npcs current = Npcs(name: npc, picture: npcsMap[npc]["picture"]);
      Npcs.insertRow(current);
    }
  }

}