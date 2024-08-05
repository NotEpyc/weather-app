// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/models/hourly_weather.dart';
import 'package:weather_app/widgets/weather_icon.dart';
import 'package:weather_app/widgets/weather_bg.dart';
import 'package:weather_app/widgets/weather_text.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});
  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String? areaName, countryCode;
  double? curTemp;
  int? weatherCod;
  List<HourlyWeather>? hourlyForecast;
  DateTime? sunrise;
  DateTime? sunset;
  

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      final position = await determinePosition();
      _getWeather(position.latitude, position.longitude);
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _getWeather(double latitude, double longitude) async {
  try {
    Weather weather = await getWeatherByLocation(latitude, longitude);
    List<HourlyWeather> hourly = await getThreeHourlyWeatherByLocation(latitude, longitude);
    setState(() {
      areaName = '${weather.areaName}';
      countryCode = '${weather.country}';
      curTemp = weather.temperature?.celsius;
      weatherCod = weather.weatherConditionCode;
      hourlyForecast = hourly;
      sunrise = weather.sunrise;
      sunset = weather.sunset;
    });
  } catch (e) {
    setState(() {
      areaName = 'Error loading data';
    });
  }
  }


  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenHeight * 0.75; // 75% of screen height
    final forecastElementHeight = screenHeight - imageHeight;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: imageHeight,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(getBackgroundImage(weatherCod ?? 0, isDayTime(DateTime.now()))),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5), 
                    offset: Offset(0, 4), 
                    blurRadius: 10, 
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),

          if (areaName == null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight,
              child: 
                Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
            ),

          if (areaName != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                          child: Text(
                          areaName ?? 'Loading...',
                          style: GoogleFonts.asap(
                            color: Colors.white,
                            fontSize: 26,
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 161, 161, 161),
                                offset: Offset(-0.5, -0.5),
                                blurRadius: 0.2,
                              ),
                              Shadow(
                                color: Color.fromARGB(255, 161, 161, 161),
                                offset: Offset(0.5, -0.5),
                                blurRadius: 0.2,
                              ),
                              Shadow(
                                color: Color.fromARGB(255, 161, 161, 161),
                                offset: Offset(-0.5, 0.5),
                                blurRadius: 0.2,
                              ),
                              Shadow(
                                color: Color.fromARGB(255, 161, 161, 161),
                                offset: Offset(0.5, 0.5),
                                blurRadius: 0.2,
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                    
                    // Spacer
                    SizedBox(height: (imageHeight/4)),
                  
                    Text(
                      '${curTemp?.toInt() ?? '--'}°C',
                      style: GoogleFonts.sofiaSansCondensed(
                        color: Colors.white,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(-1, -1),
                            blurRadius: 0.2,
                          ),
                          Shadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(1, -1),
                            blurRadius: 0.2,
                          ),
                          Shadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(-1, 1),
                            blurRadius: 0.2,
                          ),
                          Shadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(1, 1),
                            blurRadius: 0.2,
                          ),
                        ],
                      )
                    ),

                    Text(
                      weatherText(weatherCod!),
                      style: GoogleFonts.sofiaSansCondensed(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(-1, -1),
                            blurRadius: 0.2,
                          ),
                          Shadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(1, -1),
                            blurRadius: 0.2,
                          ),
                          Shadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(-1, 1),
                            blurRadius: 0.2,
                          ),
                          Shadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(1, 1),
                            blurRadius: 0.2,
                          ),
                        ],
                      )
                    ),
                      
                  ],
                ),
              ),
            ),

            if (areaName != null)
              Positioned(
                top: imageHeight + (imageHeight*0.02),
                left: 0,
                right: 0,
                height: forecastElementHeight,
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          padding: EdgeInsets.only(top: 5, bottom: 0, left: 20),
                          child: Text(
                                  'Overview',
                                  style: GoogleFonts.sofiaSansExtraCondensed(
                                    color: isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500
                                  ),
                          ),
                        ),
                        
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          padding: EdgeInsets.only(top: 22, bottom: 0, right: 15),
                          child: Text(
                                  '$areaName, $countryCode',
                                  style: GoogleFonts.sofiaSans(
                                    color: isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                      ],
                    ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              if (hourlyForecast != null)
                                forecastElement(hourlyForecast![0], isDarkMode, screenWidth),
                              if (hourlyForecast != null && hourlyForecast!.length > 1)
                                forecastElement(hourlyForecast![1], isDarkMode, screenWidth),
                              if (hourlyForecast != null && hourlyForecast!.length > 2)
                                forecastElement(hourlyForecast![2], isDarkMode, screenWidth),
                              if (hourlyForecast != null && hourlyForecast!.length > 3)
                                forecastElement(hourlyForecast![3], isDarkMode, screenWidth),
                              if (hourlyForecast != null && hourlyForecast!.length > 4)
                                forecastElement(hourlyForecast![4], isDarkMode, screenWidth),
                            ],
                        ),
                      )
                  ],
                ),
              )
        ],
      ),
    );
  }

  bool isDayTime(DateTime forecastDate) {
  if (sunrise == null || sunset == null) {
    return true;
  }
  final forecastUtc = forecastDate.toUtc();
  return forecastUtc.isAfter(sunrise!.toUtc()) && forecastUtc.isBefore(sunset!.toUtc());
  }


  Widget forecastElement(HourlyWeather forecast, bool isDarkMode, double screenWidth) {
    DateTime forecastDate = forecast.date;
    double forecastTemp = forecast.temperature;
    int weatherCode = forecast.weatherCode;

    bool daytime = isDayTime(forecastDate);
    return Container(
      width: (screenWidth/5) - ((screenWidth/5)*0.05),
      decoration: BoxDecoration(
        color: isDarkMode ? Color.fromARGB(255, 159, 159, 159) : Color.fromARGB(255, 76, 76, 76),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Text(
            DateFormat.j().format(forecastDate),
            style: GoogleFonts.sofiaSans(
              color: isDarkMode ? Colors.black : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),
          ),

          weatherIcon(weatherCode, isDarkMode, daytime, screenWidth),
          
          Text(
            '${forecastTemp.toInt()} °C',
            style: GoogleFonts.sofiaSans(
              color: isDarkMode ? Colors.black : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w300
            ),
          ),
        ],
      ),
    );
  }
}