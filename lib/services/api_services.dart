import 'dart:developer';
import 'dart:io';

import 'package:bloc_sample/model/weatherModel.dart';
import 'package:http/http.dart' as mubs;

class ApiServices {
  loadData() async {
    const url =
        "https://api.openweathermap.org/data/2.5/weather?lat=27.25&lon=49.71&units=metric&appid=fb44150289e06f7e5d47c0b8c7515e20";
    var pathUrl = Uri.parse(url);
    try {
      var response = await mubs.get(
        pathUrl,
      );
      log("dataaaaaaaa${response.body}");
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        String responseString = response.body;
        Weather data = weatherFromJson(responseString);
        return data;
      }
    } on SocketException {
      return "Network Error";
    } catch (e) {
      return e;
    }
  }
}
