class HourlyWeather {
  final DateTime date;
  final double temperature;
  final int weatherCode;
  final DateTime? sunrise; // Nullable
  final DateTime? sunset;  // Nullable

  HourlyWeather({
    required this.date,
    required this.temperature,
    required this.weatherCode,
    this.sunrise, // Nullable
    this.sunset,  // Nullable
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json, DateTime? sunrise, DateTime? sunset) {
  return HourlyWeather(
    date: DateTime.fromMillisecondsSinceEpoch((json['dt'] ?? 0) * 1000),
    temperature: (json['main']?['temp']?.toDouble() ?? 0.0),
    weatherCode: (json['weather'] != null && json['weather'].isNotEmpty)
        ? (json['weather'][0]['id'] ?? 0)
        : 0,
    sunrise: sunrise ?? DateTime.now(), // Use current time if null
    sunset: sunset ?? DateTime.now(),   // Use current time if null
  );
  }

}
