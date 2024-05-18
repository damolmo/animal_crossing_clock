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

class ClockScreenModel extends BaseViewModel implements Initialisable{

  int currentSeconds = 0;
  int currentMinutes = 0;
  int currentHour = 0;
  int currentMonth = 0;
  int currentDay = 0;
  int currentYear = 0;
  String currentWeekDay = "";
  Times currentTime =  Times(hour: "", sound: "", sky: "");
  Stations currentStation = Stations(name: "Winter", path: "assets/paths/winter.png", tree: "assets/trees/winter_tree.png");
  DayMonthYearStation dayMonthYearStation = DayMonthYearStation(day: "day", month: "month", year: "year", station: "station");
  AudioPlayer player = AudioPlayer();
  AudioPlayer balloonPlayer = AudioPlayer();
  AudioPlayer totakaPlayer = AudioPlayer();
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
  List<TotaSongs> songs = [];
  int balloonCounter = 0;
  List<String> npcsString = [];
  List<Npcs> npcs = [];
  int balloonIndex = 0;
  Balloons currentBalloon = Balloons(npcID: "npcID", asset: "asset");
  bool isAldeano = false;
  bool isTota = false;
  bool isCanela = false;
  bool isTendoNendo = false;
  bool isTotakaMenu = false;
  bool isTotakaPlaying = false;
  int choosedSongIndex = 999;
  int positionCounter = 0;
  String savedPosition =  "";
  bool isWebListenerEnabled = false;

  // Values used for disc rotation

  @override
  void initialise() async  {
    if (kIsWeb){
      getDeviceTimeStamp(); // Background
      retrieveTimeData();
      retrieveExistingStations();
      playBackgroundMusic();
      await enableListeners();
      enableTotakaListeners();
      waitingBalloonLaunch();
      getTotakaSongs();
      isMusicPlaying = false;
      notifyListeners();
    } else {
      await getDeviceTimeStamp(); // Background
      await retrieveTimeData();
      await retrieveExistingStations();
      await playBackgroundMusic();
      await enableListeners();
      await enableTotakaListeners();
      await waitingBalloonLaunch();
      await getTotakaSongs();
      isMusicPlaying = true;
      notifyListeners();
    }
  }

  getTotakaSongs() async {
    // A method that retrieves and inserts totaka songs into database
    try{
      songs = await TotaSongs.retrieveCurrentSongs();
      notifyListeners();
    } catch (e){
      SongsData.insertSongsIntoTable();
      songs = await TotaSongs.retrieveCurrentSongs();
      notifyListeners();
    }
  }

  pauseResumeMainPlayer() async {
    if (isTotakaPlaying){
      // Since the player is awaiting for data
      // Leaving it listening on the background can lead to an application free
      // Release this player
      player.stop();
      player.release();
    } else {
      playBackgroundMusic();
    }
  }

  playChoosedTotakaSong(bool isGonnaPlay) async {
    // A split method to play/pause totaka songs based on a different index
    if (isGonnaPlay){
      pauseResumeMainPlayer();
      totakaPlayer.play(UrlSource(songs[choosedSongIndex].songPath, mimeType: "mp3" ));
    } else {
      totakaPlayer.stop();
      totakaPlayer.release();

      // Notify to main player to continue with current songs
      isTotakaPlaying = false;
      notifyListeners();
      pauseResumeMainPlayer();
    }
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
            if (!isTotakaPlaying){
              playBackgroundMusic();
            }
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
            if (!isTotakaPlaying){
              player.pause();
              player.stop();
              playBackgroundMusic();
            }

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
      notifyListeners();
  }

  formatCompareDurations(Duration d, String type) async {
    // A method that receives a duration and listener type

    int minutes = d.inMinutes;
    int seconds = d.inSeconds;

    if (type == "full"){
      // This will called once on every start
      totalDuration = "$minutes:$seconds"; // To avoid a very well known bug
      notifyListeners();
    } else {
      currentDuration = "$minutes:$seconds";
      notifyListeners();
    }

  }

  playNextTotaSong(){
    if (songs.length - 1 > choosedSongIndex){
      choosedSongIndex+=1;
      notifyListeners();
      playChoosedTotakaSong(true);
    } else {
      choosedSongIndex = 0;
      notifyListeners();
      playChoosedTotakaSong(true);
    }
  }

  enableTotakaListeners() async {
    // Enable some listeners to retrieve some data

    totakaPlayer.onDurationChanged.listen((Duration d) {
      formatCompareDurations(d, "full");
    });

    totakaPlayer.onPositionChanged.listen((Duration d) {
      formatCompareDurations(d, "current");
    });

    totakaPlayer.onPlayerComplete.listen((onData){
      resumeCurrentSong();
    });

  }

  enableListeners() async {
    // Enable some listeners to retrieve some data

    player.onDurationChanged.listen((Duration d) {
      formatCompareDurations(d, "full");
    });

    player.onPositionChanged.listen((Duration d) {
      formatCompareDurations(d, "current");
    });

    player.onPlayerComplete.listen((onData){
      resumeCurrentSong();
    });
  }

  resumeCurrentSong() async {
    if (isTotakaPlaying){
      totakaPlayer.stop();
      totakaPlayer.release();
      playNextTotaSong();
    } else {
      player.stop();
      player.release();
      playBackgroundMusic();
      notifyListeners();
    }
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

  void resumeMusic() async {
    // Web browser needs manual initialization of music player
    if (isTotakaPlaying){
      totakaPlayer.stop();
      totakaPlayer.release();
      isTotakaPlaying = false;
      isMusicPlaying = false;
      notifyListeners();
    } else if (isMusicPlaying) {
      player.stop();
      player.release();
      isMusicPlaying = false;
      notifyListeners();
    } else {
      isMusicPlaying = true;
      notifyListeners();
      playBackgroundMusic();
      }
    }

  waitingBalloonLaunch() async {
    // A method to wait some time before launching a balloon

    CountdownTimer timer = CountdownTimer(const Duration(hours: 24), const Duration(seconds: 1));
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

}