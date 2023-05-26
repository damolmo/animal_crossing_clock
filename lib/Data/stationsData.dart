import '../exports.dart';

class StationsData {

  static Map<String,dynamic> stationsMap = {

    "Spring" : {
      "path" : "assets/paths/spring.png",
      "tree" :  "assets/trees/blossom_tree.png"
    },

    "Summer" : {
      "path" : "assets/paths/summer.png",
      "tree" : "assets/trees/palm_tree.png",
    },

    "Autumn" : {
      "path"  : "assets/paths/autumn.png",
      "tree" :  "assets/trees/autumn_tree.png"
    },

    "Winter" :  {
      "path" :  "assets/paths/winter.png",
      "tree" :  "assets/trees/winter_tree.png"
    },
  };

  static insertStationsData() async {
    // A method that insert a new station in stations table
    Stations.createStationsTable(); // To be executed once

    for (String station in stationsMap.keys){
      Stations current = Stations(name : station, path : stationsMap[station]["path"], tree : stationsMap[station]["tree"]);
      Stations.insertStation(current);
    }
  }


}