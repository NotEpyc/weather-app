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
  String? areaName, countryCode, locationName='';
  double? curTemp;
  int? weatherCod;
  List<HourlyWeather>? hourlyForecast;
  DateTime? sunrise, sunset;
  bool isSearchVisible = false;
  double searchBarWidth = 48.0;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              ),
            ),
          ),
          Positioned(
            top: imageHeight-25, // Default IconButton size = 48 and padding = 2
            right: 10,
            child: Container(
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: isDarkMode ? Color.fromARGB(255, 70, 69, 69) : Color.fromARGB(255, 225, 225, 225),
              ),
              child: IconButton(
                onPressed: _getLocation,
                icon: Icon(Icons.refresh_rounded, color: isDarkMode ? Colors.white : Colors.black,),
                iconSize: 24,
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
                  color: isDarkMode ? Colors.black : Colors.white,
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
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                          child: Text( 
                          isSearchVisible ? '' : (areaName ?? 'Loading...'),
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
                      weatherCod != null ? weatherText(weatherCod!) : 'Loading...',
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
                top: imageHeight,
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
                          padding: EdgeInsets.only(top: 15, bottom: 0, left: 20),
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
                          padding: EdgeInsets.only(top: 25, bottom: 0, right: 15),
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

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (hourlyForecast != null)
                              for (int i = 1; i < 9; i++) ...[
                                forecastElement(hourlyForecast![i], isDarkMode, screenWidth),
                                if (i < 8) SizedBox(width: 5.0),
                              ]
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

            if (areaName != null)
            Positioned(
            top: 29,
            right: 10,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              alignment: Alignment.topRight,
              height: 48,
              width: searchBarWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: isSearchVisible? Color.fromARGB(255, 41, 41, 41).withOpacity(0.5) : Color.fromARGB(255, 41, 41, 41).withOpacity(0.1),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isSearchVisible) {
                          searchBarWidth = 48.0;
                          isSearchVisible = false;
                        } else {
                          searchBarWidth = MediaQuery.of(context).size.width - 20;
                          isSearchVisible = true;
                        }
                      });
                    },
                    icon: Icon(
                      isSearchVisible ? Icons.arrow_back_ios_new_rounded : Icons.search_rounded,
                      color: Colors.white,
                    ),
                    iconSize: 24,
                  ),
                  if (isSearchVisible)
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (text) {},
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter location",
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 175, 175, 175)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (isSearchVisible)
                    IconButton(
                      onPressed: () {
                        // Add search action here
                      },
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                      ),
                      iconSize: 24,
                    ),
                ],
              ),
            ),
          ), 
        ],
      ),
    );
  }

  bool isDayTime(DateTime forecastDate) {
  if (sunrise == null || sunset == null) {
    return true;
  }

  DateTime forecastUtc = forecastDate;
  DateTime sunriseUtc = DateTime(
    forecastDate.year,
    forecastDate.month,
    forecastDate.day,
    sunrise!.hour,
    sunrise!.minute,
    sunrise!.second,
  );

  DateTime sunsetUtc = DateTime(
    forecastDate.year,
    forecastDate.month,
    forecastDate.day,
    sunset!.hour,
    sunset!.minute,
    sunset!.second,
  );

  if (sunsetUtc.isBefore(sunriseUtc)) {
    sunsetUtc = sunsetUtc.add(Duration(days: 1));
  }

  bool isDay = forecastUtc.isAfter(sunriseUtc) && forecastUtc.isBefore(sunsetUtc);
  return isDay;
}


  Widget forecastElement(HourlyWeather forecast, bool isDarkMode, double screenWidth) {
    DateTime forecastDate = forecast.date;
    double forecastTemp = forecast.temperature;
    int weatherCode = forecast.weatherCode;

    bool daytime = isDayTime(forecastDate);
    return Container(
      width: (screenWidth/5) - ((screenWidth/5)*0.06),
      decoration: BoxDecoration(
        color: isDarkMode ? Color.fromARGB(255, 70, 69, 69) : Color.fromARGB(255, 225, 225, 225),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Text(
            DateFormat.j().format(forecastDate),
            style: GoogleFonts.sofiaSans(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),
          ),

          weatherIcon(weatherCode, isDarkMode, daytime, screenWidth),
          
          Text(
            '${forecastTemp.toInt()} °C',
            style: GoogleFonts.sofiaSans(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w300
            ),
          ),
        ],
      ),
    );
  }
}