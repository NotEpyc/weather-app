String weatherText(int weatherCod) {
  String conditonText = '';
  switch (weatherCod) {

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
        conditonText = 'Thunderstorm';
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
        conditonText = 'Drizzle';
        break;

      // Group 5xx: Rain
      case 500:
      case 520:
      case 501:
      case 521:
        conditonText = 'Light Rain';
        break;
      case 502:
      case 503:
      case 504:
      case 511:
      case 522:
      case 531:
        conditonText = 'Heavy Rain';
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
        conditonText = 'Snow';
        break;

      // Group 7xx: Atmosphere
      case 701:
        conditonText = 'Mist';
        break;
      case 711:
        conditonText = 'Smoke';
        break;
      case 721:
        conditonText = 'Haze';
        break;
      case 731:
        conditonText = 'Dust Whirls';
        break;
      case 741:
        conditonText = 'Fog';
        break;
      case 751:
      case 761:
      case 762:
        conditonText = 'Dust';
        break;
      case 771:
        conditonText = 'Squall';
        break;
      case 781:
        conditonText = 'Tornado';
        break;

      // Group 800: Clear Sky
      case 800:
        conditonText = 'Clear Sky';
        break;
      case 801:
      case 802:
      case 803:
      case 804:
        // Clouds
        conditonText = 'Cloudy';
        break;
      default:
        // Default text for other conditions
        conditonText = '';
        break;
    }

    return conditonText;
}