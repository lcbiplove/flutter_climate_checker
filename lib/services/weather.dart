import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String kapiKey = '7fd00f086cb692e4a5cba1968776ca36';
const String kopenMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationFromCityName(String cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper('$kopenMapURL?q=$cityName&appid=$kapiKey&units=metric');
    var weatherData = await networkHelper.getDecodedData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$kopenMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kapiKey&units=metric');
    var weatherData = await networkHelper.getDecodedData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
