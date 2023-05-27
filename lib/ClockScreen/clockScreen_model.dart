import 'package:flutter/foundation.dart';
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
  Times currentTime =  Times(hour: "hour", sound: "sound", sky: "sky");
  Stations currentStation = Stations(name: "name", path: "path", tree: "tree");
  DayMonthYearStation dayMonthYearStation = DayMonthYearStation(day: "day", month: "month", year: "year", station: "station");
  AudioPlayer player = AudioPlayer();
  String currentDuration = "0:0";
  String totalDuration = "";
  String fixedDuration = "";
  String additionalZeroMinute = "";
  String additionalZeroHour = "";
  bool isMusicPlaying = false;
  bool retrieveSongData = false;

  @override
  void initialise() async {
    await getDeviceTimeStamp(); // Background
    await retrieveTimeData();
    await retrieveExistingStations();
    await checkPlayerStopped();
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
      print("$currentDuration/$totalDuration");


      if (currentDuration == totalDuration || currentDuration == fixedDuration){
        // Start playing again, notify listeners
        currentDuration = "0:0";
        player.pause();
        player.stop();
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
      enableListeners(); // Check player flow
    }

  checkPlayerStopped() async {
    // Sometimes the player may stop working without any suer iteraction
    // We need a background service preventing this

    CountdownTimer counter = CountdownTimer(Duration(hours: 24), Duration(seconds: 1));
    var listener = counter.listen(null);
    int secondsWithoutPlayer = 0;

    listener.onData((data) {
      if (currentDuration == "0:0") secondsWithoutPlayer++;
      if (secondsWithoutPlayer >=2){
        // We need to force a restart of the listeners
        // Sometimes the count stops working but the sound plays once on this state
        secondsWithoutPlayer = 0;
        playBackgroundMusic();
      }
    });
  }

}