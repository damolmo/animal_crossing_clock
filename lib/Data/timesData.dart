
import 'package:animal_crossing_clock/Databases/times.dart';

class TimesData{

  static Map<String,dynamic> timesMap = {

    "0" : {
      "sound" :  "assets/soundtracks/12AM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },

    "1" : {
      "sound" :  "assets/soundtracks/1AM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },

    "2" : {
      "sound" :  "assets/soundtracks/2AM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },

    "3" : {
      "sound" :  "assets/soundtracks/3AM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },

    "4" : {
      "sound" :  "assets/soundtracks/4AM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },

    "5" : {
      "sound" : "assets/soundtracks/5AM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },

    "6" : {
      "sound" :  "assets/soundtracks/6AM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "7" : {
      "sound" :  "assets/soundtracks/7AM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "8" : {
      "sound" :  "assets/soundtracks/8AM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "9" : {
      "sound" :  "assets/soundtracks/9AM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "10" : {
      "sound" :  "assets/soundtracks/10AM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "11" : {
      "sound" :  "assets/soundtracks/11AM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "12" : {
      "sound" :  "assets/soundtracks/12PM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "13" : {
      "sound" :  "assets/soundtracks/1PM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "14" : {
      "sound" :  "assets/soundtracks/2PM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "15" : {
      "sound" :  "assets/soundtracks/3PM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "16" : {
      "sound" :  "assets/soundtracks/4PM.mp3",
      "sky" :  "assets/sky/morning.jpeg"
    },

    "17" : {
      "sound" :  "assets/soundtracks/5PM.mp3",
      "sky" :  "assets/sky/afternoon.png"
    },

    "18" : {
      "sound" :  "assets/soundtracks/6PM.mp3",
      "sky" :  "assets/sky/afternoon.png"
    },

    "19" : {
      "sound" :  "assets/soundtracks/7PM.mp3",
      "sky" :  "assets/sky/pre_evening.png"
    },

    "20" : {
      "sound" :  "assets/soundtracks/8PM.mp3",
      "sky" :  "assets/sky/pre_evening.png"
    },

    "21" : {
      "sound" :  "assets/soundtracks/9PM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },

    "22" : {
      "sound" :  "assets/soundtracks/10PM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },

    "23" : {
      "sound" :  "assets/soundtracks/11PM.mp3",
      "sky" :  "assets/sky/evening.jpeg"
    },
  };

  static insertTimesData() async {
    // A static method that creates an instance of time from given HashMap

    Times.createTimesTable(); // To be executed once

    for (String time in timesMap.keys ){
      Times current = Times(hour: time, sound: timesMap[time]["sound"], sky: timesMap[time]["sky"]);
      Times.insertTimeRow(current);
    }
  }

}