import 'dart:math';
import 'package:animal_crossing_clock/Data/npcsData.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:quiver/async.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';
import 'package:audioplayers/audioplayers.dart';

class ClockScreenModel extends BaseViewModel implements Initialisable, TickerProvider{

  int currentSeconds = 0;
  int currentMinutes = 0;
  int currentHour = 0;
  int currentMonth = 0;
  int currentDay = 0;
  int currentYear = 0;
  String currentWeekDay = "";
  Times currentTime =  Times(hour: "hour", sound: "sound", sky: "sky");
  Stations currentStation = Stations(name: "name", path: "path", tree: "tree");
  DayMonthYearStation dayMonthYearStation = DayMonthYearStation(day: "day", month: "month", year: "year", station: "station");
  AudioPlayer player = AudioPlayer();
  AudioPlayer balloonPlayer = AudioPlayer();
  String currentDuration = "0:0";
  String totalDuration = "";
  String fixedDuration = "";
  String additionalZeroMinute = "";
  String additionalZeroDay = "";
  String additionalZeroHour = "";
  bool isMusicPlaying = false;
  bool retrieveSongData = false;
  bool launchingBalloon = false;
  int balloonWaitTime = 0;
  double marginLeft = 0.8;
  double marginRight = 0.0;
  List<int> npcIndexes = [];
  List<String> npcName = [];
  int balloonCounter = 0;
  List<String> npcsString = [];
  List<Npcs> npcs = [];
  int balloonIndex = 0;
  Balloons currentBalloon = Balloons(npcID: "npcID", asset: "asset");
  bool isAldeano = false;
  bool isTota = false;
  bool isCanela = false;
  bool isTendoNendo = false;

  // Values used for disc rotation

  @override
  void initialise() async {
    await getDeviceTimeStamp(); // Background
    await retrieveTimeData();
    await retrieveExistingStations();
    await playBackgroundMusic();
    await enableListeners();
    await waitingBalloonLaunch();
  }

  getWeekDayString(int weekDayIndex) {
    switch (weekDayIndex) {
      case 1 :
        return "Lun";

      case 2 :
        return "Mar";


      case 3 :
        return "Mie";


      case 4 :
        return "Jue";


      case 5 :
        return "Vie";

      case 6 :
        return "Sab";

      case 7 :
        return "Dom";
    }
  }

  getDeviceTimeStamp() async {
    // This method get current device timeStamp
    // This will handle the loop for 24h!

    CountdownTimer timer = CountdownTimer(const Duration(hours: 24), const Duration(seconds: 1));
    final DateTime timeStamp = DateTime.now();
    currentSeconds = timeStamp.second;
    currentMinutes = timeStamp.minute;
    currentHour =  timeStamp.hour;
    currentDay = timeStamp.day;
    currentMonth = timeStamp.month;
    currentYear =  timeStamp.year;
    currentWeekDay = getWeekDayString(timeStamp.weekday);
    notifyListeners();

    if (currentHour < 10) additionalZeroHour = "0";
    if (currentMinutes < 10) additionalZeroMinute = "0";
    if(currentDay < 10) additionalZeroDay = "0";
    notifyListeners();

    var counter = timer.listen(null);


    counter.onData((data) {

      if (currentSeconds < 59){
        currentSeconds++;
        notifyListeners();
      } else {
        currentSeconds = 0;
        notifyListeners();
        if (currentMinutes < 59){
          currentMinutes++;
          notifyListeners();
          if(currentMinutes <=9){
            additionalZeroMinute = "0";
            notifyListeners();
          } else {
            additionalZeroMinute = "";
            notifyListeners();
          }
        } else {
          currentMinutes = 0;
          additionalZeroMinute = "0";
          notifyListeners();
          if (currentHour < 23){
            currentHour ++;
            notifyListeners();
            retrieveTimeData();
            player.pause();
            player.stop();
            playBackgroundMusic();
            if (currentHour < 10){
              additionalZeroHour =  "0";
              notifyListeners();
            } else {
              additionalZeroHour = "";
              notifyListeners();
            }
          } else {
            currentHour = 0;
            currentDay ++;
            notifyListeners();
            retrieveTimeData();
            player.pause();
            player.stop();
            playBackgroundMusic();
          }
        }
      }
    });
  }

  retrieveTimeData() async {
    // A method to retrieve existing times data from database
    // If not data found, insert existing data in app

    try {
      currentTime =  await Times.retrieveTimes(currentHour.toString());
      notifyListeners();
    } catch (e) {
      // Oops, looks like Times table wasn't created yet or/and table hasn't any row yet
      TimesData.insertTimesData();
      currentTime = await Times.retrieveTimes(currentHour.toString());
      notifyListeners();
    }

  }

  retrieveExistingStations() async {
    // To get current station, we need to get current day, month and year

    try{
      dayMonthYearStation = await DayMonthYearStation.retrieveRow(currentYear.toString(), currentMonth.toString(), currentDay.toString());
      notifyListeners();
    } catch (e){
      DayMonthYearStationData.insertData();
      dayMonthYearStation = await DayMonthYearStation.retrieveRow(currentYear.toString(), currentMonth.toString(), currentDay.toString());
      notifyListeners();
    }

    // Get current station
    try {
      currentStation = await Stations.retrieveStations(dayMonthYearStation.station);
      notifyListeners();
    } catch (e){
      StationsData.insertStationsData();
      currentStation = await Stations.retrieveStations(dayMonthYearStation.station);
      notifyListeners();
    }

  }

  playCurrentHourSong(){
    // If notified, current player will stop playing a song
      player.play(AssetSource(currentTime.sound.replaceAll("assets/", "")));
  }

  formatCompareDurations(Duration d, String type) async {
    // A method that receives a duration and listener type

    int minutes = Duration(minutes: d.inMinutes).inMinutes;
    int seconds = Duration(seconds: d.inSeconds).inSeconds;

    if (type == "full"){
      // This will called once on every start
      totalDuration = "$minutes:$seconds"; // To avoid a very well known bug
      fixedDuration = "$minutes:${seconds - 1}";
      notifyListeners();
    } else {
      currentDuration = "$minutes:$seconds";
      notifyListeners();


      if (currentDuration == totalDuration || currentDuration == fixedDuration){
        // Start playing again, notify listeners
        currentDuration = "0:0";
        player.stop();
        player.release();
        playBackgroundMusic();
        notifyListeners();
      }
    }

  }

  enableListeners() async {
    // Enable some listeners to retrieve some data
    player.onDurationChanged.listen((Duration d) {
      formatCompareDurations(d, "full");
    });

    player.onPositionChanged.listen((Duration d) {
      formatCompareDurations(d, "current");
    });
  }

  playBackgroundMusic() async {
    // A method to play music on background all time :)
      playCurrentHourSong(); // Play some music
    }

  retrieveExistingNpcs() async {
    // A method to retrieve or insert and retrieve existing npcs

    // Retrieve existing npcs
    try {
      npcs = await Npcs.retrieveNpcs();
      notifyListeners();
    } catch (e){
      NpcsData.insertNpcsData();
      npcs = await Npcs.retrieveNpcs();
      notifyListeners();
    }

    for (Npcs npc in npcs){
      npcsString.add(npc.name);
      notifyListeners();
    }

  }

  retrieveCurrentBalloon(String balloonName) async {
    // A method to retrieve a balloon from given name

    try {
      currentBalloon = await Balloons.retrieveCurrentNpcBalloon(balloonName);
      notifyListeners();
    } catch (e){
      BalloonsData.insertNpcData();
      currentBalloon = await Balloons.retrieveCurrentNpcBalloon(balloonName);
      notifyListeners();
    }
  }

  waitingBalloonLaunch() async {
    // A method to wait some time before launching a balloon

    CountdownTimer timer = CountdownTimer(Duration(hours: 24), Duration(seconds: 1));
    var listener = timer.listen(null);

    listener.onData((data) {
      if (balloonWaitTime < 120 && !launchingBalloon && npcIndexes.length < 4){
        balloonWaitTime++;
        notifyListeners();
      } else if (balloonWaitTime >= 120) {
        // After 5 minutes, a new balloon is ready to launch!
        balloonWaitTime = 0;
        notifyListeners();
        launchBalloonEvent();
      }
    });
  }


  launchBalloonEvent() async {
    // A method to launch a ballon on screen every 5 minutes
    Random randomBalloon = Random();

    if (npcs.isEmpty){
      await retrieveExistingNpcs();
    }

    balloonIndex = randomBalloon.nextInt(npcs.length);

    if (npcIndexes.contains(balloonIndex)){
      while(npcIndexes.contains(balloonIndex)){
        balloonIndex = randomBalloon.nextInt(npcs.length);
      }
    }

    retrieveCurrentBalloon(npcs[balloonIndex].name);
    launchingBalloon = true;
    playBalloonSound();
    notifyListeners();

    // Control the balloon movement
    balloonPhysics();
  }

  playBalloonSound() async {
    // A simple method to play a balloon sound once
    // This plays every time a new balloon is launch
    balloonPlayer.play(AssetSource("soundtracks/balloon.m4a"));
  }

  balloonPhysics() async {
    // A method to control balloon movement on display
    // Allow user to push it while on display
    // Also enable sound effect and X-Y axis movement
    CountdownTimer counter = CountdownTimer(Duration(seconds: 30), Duration(seconds: 1));
    var listener = counter.listen(null);

    listener.onData((data) {
      if (balloonCounter < 30){
        // Decrease left axis
        // Balloon movement is from right to left
        marginLeft -= 0.026;
        marginRight += 0.026;
        balloonCounter ++;
        awaitBalloonEnd();
        notifyListeners();
      }
    }
    );
  }

  awaitBalloonEnd() async {
    // A method to hide balloon after 30s

    CountdownTimer timer = CountdownTimer(Duration(seconds: 40), Duration(seconds: 1));
    var listener = timer.listen(null);

    listener.onData((data) {
      if (balloonCounter == 30){
        launchingBalloon = false;
        balloonCounter = 0;
        marginLeft = 0.8;
        marginRight = 0.0;
        notifyListeners();
      }
    });
  }

  addNpcToAchieved() async {
    // A method to add current npc to achieved list
    npcName.add(currentBalloon.npcID);
    npcIndexes.add(balloonIndex);
    notifyListeners();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    // TODO: implement createTicker
    throw UnimplementedError();
  }

}