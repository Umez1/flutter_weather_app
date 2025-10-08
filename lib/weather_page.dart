import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const WeatherPage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _weatherService = WeatherService();

  Map<String, dynamic>? _weatherData;
  bool _loading = false;
  String? _error;

  Future<void> _getWeather() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final data = await _weatherService.fetchWeather(_controller.text.trim());
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      setState(() {
        _error = "City not found or failed to fetch data";
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  // Choose animation for weather
  String _getAnimationForWeather(String condition) {
    condition = condition.toLowerCase();
    if (condition.contains("thunder")) {
      return "assets/animations/thunder.json";
    } else if (condition.contains("rain")) {
      return "assets/animations/rain.json";
    } else if (condition.contains("cloud")) {
      return "assets/animations/cloudy.json";
    } else {
      return "assets/animations/sunny.json"; // default
    }
  }

  Widget _buildWeatherAnimation(String path) {
    try {
      return Opacity(
        opacity: 0.6,
        child: Lottie.asset(
          path,
          fit: BoxFit.cover,
          repeat: true,
          animate: true,
          key: ValueKey<String>(path), // Important for AnimatedSwitcher
        ),
      );
    } catch (e) {
      print("Error loading Lottie animation: $e");
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    String? animationPath;
    if (_weatherData != null) {
      animationPath = _getAnimationForWeather(
        _weatherData!['weather'][0]['main'].toLowerCase(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            isDarkMode
                ? "assets/images/bg_dark.jpg"
                : "assets/images/bg_light.jpg",
            fit: BoxFit.cover,
          ),

          // Lottie animation with fade transition
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: animationPath != null
                ? _buildWeatherAnimation(animationPath)
                : const SizedBox.shrink(),
          ),

          // Foreground UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Enter city name",
                          labelStyle: const TextStyle(color: Colors.white),
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.black45,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _getWeather,
                        child: const Text("Get Weather"),
                      ),
                      const SizedBox(height: 20),

                      if (_loading) const CircularProgressIndicator(),

                      if (_error != null)
                        Text(
                          _error!,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      if (_weatherData != null)
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "${_weatherData!['name']}, ${_weatherData!['sys']['country']}",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${_weatherData!['main']['temp']} °C",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Image.network(
                              "http://openweathermap.org/img/wn/${_weatherData!['weather'][0]['icon']}@2x.png",
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _weatherData!['weather'][0]['description'],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
