import 'package:flutter/material.dart';
import 'package:superapp/models/weather_model.dart';
import 'package:superapp/services/weather_service.dart';
import 'package:superapp/components/drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('b66031feda86a5fe17da3650d89f2c88');
  Weather? _weather;
  // fetch
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState((){_weather = weather;});
    }
    catch (e) {
      print(e);
    }
  }
  // init
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }
  
  String getWeatherAnimaiton(String? mainCondition) {
    if (mainCondition == null){
      return 'assets/cloud.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/cloud.json';
    }
    return 'assets/cloud.json';
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text('Notes')
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            _weather?.cityName ?? "loading city...",
            style: GoogleFonts.dmSerifText(
              fontSize: 32,
              color: Theme.of(context).colorScheme.inversePrimary
              ),
            ),
          Lottie.asset(getWeatherAnimaiton(_weather?.mainCondition)),
          Text(
            '${_weather?.temperature.round()}°C',
            style: GoogleFonts.dmSerifText(
              fontSize: 48,
              color: Theme.of(context).colorScheme.inversePrimary
              ),
          )
        ],
        ),
      ),
    );
  }
}