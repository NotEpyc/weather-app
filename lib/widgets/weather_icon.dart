import 'package:flutter/material.dart';

Widget weatherIcon(int weatherCode, bool isDarkMode, bool daytime, double screenWidth) {
  String imagePath = '';
  double elementDimension = (screenWidth/5)-((screenWidth/5)*0.36);

  switch (weatherCode) {
    // Group 2xx: Thunderstorm
    case 200:
    case 201:
    case 202:
    case 210:
    case 211:
    case 212:
    case 221:
    case 230:
    case 231:
    case 232:
      imagePath = isDarkMode? 'assets/weather_icons/dark/thunderstorm.png' : 'assets/weather_icons/light/thunderstorm.png';
      break;

    // Group 3xx: Drizzle
    case 300:
    case 301:
    case 302:
    case 310:
    case 311:
    case 312:
    case 313:
    case 314:
    case 321:
      imagePath = isDarkMode? 'assets/weather_icons/dark/rain.png' : 'assets/weather_icons/light/rain.png';
      break;

    // Group 5xx: Rain
    case 500:
    case 501:
    case 502:
    case 503:
    case 504:
      imagePath = daytime? (isDarkMode? 'assets/weather_icons/dark/rain-d.png' : 'assets/weather_icons/light/rain-d.png') : (isDarkMode? 'assets/weather_icons/dark/rain-n.png' : 'assets/weather_icons/light/rain-n.png');
      break;
    case 511:
      imagePath = isDarkMode? 'assets/weather_icons/dark/snow.png' : 'assets/weather_icons/light/snow.png';
      break;
    case 520:
    case 521:
    case 522:
    case 531:
      imagePath = isDarkMode? 'assets/weather_icons/dark/rain.png' : 'assets/weather_icons/light/rain.png';
      break;

    // Group 6xx: Snow
    case 600:
    case 601:
    case 602:
    case 611:
    case 612:
    case 613:
    case 615:
    case 616:
    case 620:
    case 621:
    case 622:
      imagePath = isDarkMode? 'assets/weather_icons/dark/snow.png' : 'assets/weather_icons/light/snow.png';
      break;

    // Group 7xx: Atmosphere
    case 701:
    case 721:
    case 741:
      imagePath = isDarkMode? 'assets/weather_icons/dark/fog.png' : 'assets/weather_icons/light/fog.png';
      break;
    case 711:
    case 731:
    case 751:
    case 761:
    case 762:
      imagePath = isDarkMode? 'assets/weather_icons/dark/dust.png' : 'assets/weather_icons/light/dust.png';
      break;
    case 771:
      imagePath = isDarkMode? 'assets/weather_icons/dark/wind.png' : 'assets/weather_icons/light/wind.png';
      break;
    case 781:
      imagePath = isDarkMode? 'assets/weather_icons/dark/tornado.png' : 'assets/weather_icons/light/tornado.png';
      break;

    // Group 800: Clear Sky
    case 800:
      imagePath = daytime? (isDarkMode? 'assets/weather_icons/dark/sun.png' : 'assets/weather_icons/light/sun.png') : (isDarkMode? 'assets/weather_icons/dark/moon.png' : 'assets/weather_icons/light/moon.png');
      break;

    // Group 80x: Clouds
    case 801:
      imagePath = daytime? (isDarkMode? 'assets/weather_icons/dark/cloud-d.png' : 'assets/weather_icons/light/cloud-d.png') : (isDarkMode? 'assets/weather_icons/dark/cloud-n.png' : 'assets/weather_icons/light/cloud-n.png');
      break;
    case 802:
      imagePath = isDarkMode? 'assets/weather_icons/dark/cloud.png' : 'assets/weather_icons/light/cloud.png';
      break;
    case 803:
    case 804:
      imagePath = isDarkMode? 'assets/weather_icons/dark/cloudy.png' : 'assets/weather_icons/light/cloudy.png';
      break;

    default:
      daytime? (isDarkMode? 'assets/weather_icons/dark/sun.png' : 'assets/weather_icons/light/sun.png') : (isDarkMode? 'assets/weather_icons/dark/moon.png' : 'assets/weather_icons/light/moon.png');
      break;
  }

  return SizedBox(
    height: elementDimension,
    width: elementDimension,
    child: Image.asset(imagePath)
    );
}