import '../exports.dart';

class MonthsData {


  static Map<String,dynamic> monthsData = {
    "1" :  {
      "name" : "January"
    },

    "2" : {
      "name" :  "February"
    },

    "3" :  {
      "name" : "March"
    },

    "4" : {
      "name" :  "April"
    },

    "5" :  {
      "name" : "May"
    },

    "6" : {
      "name" :  "June"
    },

    "7" :  {
      "name" :  "July"
    },

    "8" : {
      "name" : "August"
    },

    "9" : {
      "name" : "September"
    },

    "10" : {
      "name" : "October"
    },

    "11" :  {
      "name" : "November"
    },

    "12" : {
      "name" :  "December"
    }
  };

  static insertMonthsData() async {
    // A static method to insert months data into months table

    Months.createMonthsTable(); // To be executed once

    for (String month in monthsData.keys){
      Months current = Months(month: month, station: monthsData[month]["name"]);
      Months.insertMonthRow(current);
    }
  }

}