String getBackgroundImage(int weatherCode, bool daytime) {
    String imagePath = '';
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
        imagePath = 'assets/weather_background/thunderstorm.jpg';
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

      // Group 5xx: Rain
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
      case 511:
      case 520:
      case 521:
      case 522:
      case 531:
        imagePath = 'assets/weather_background/rain.jpg';
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
        imagePath = 'assets/weather_background/snow.jpg';
        break;

      // Group 7xx: Atmosphere
      case 701:
      case 721:
      case 741:
        imagePath = 'assets/weather_background/fog.jpg';
        break;
        case 711:
      case 731:
      case 751:
      case 761:
      case 762:
        imagePath = 'assets/weather_background/dust.jpg';
        break;
      case 771:
      case 781:
        imagePath = 'assets/weather_background/tornado.jpg';
        break;

      // Group 800: Clear Sky
      case 800:
        imagePath = daytime? 'assets/weather_background/clear_day.jpg' : 'assets/weather_background/clear_night.jpg';
      case 801:
      case 802:
      case 803:
      case 804:
        // Clouds
        imagePath = daytime? 'assets/weather_background/day_cloud.jpg' : 'assets/weather_background/night_cloud.jpg';
        break;

      default:
        // Default image or gradient for other conditions
        imagePath = daytime? 'assets/weather_background/clear_day.jpg' : 'assets/weather_background/clear_night.jpg';
        break;
    }

    return imagePath;
}