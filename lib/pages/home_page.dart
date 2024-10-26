import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/utils/weather_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    provider.setWeatherDataForCurrent(); // Fetch current weather data
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              provider.backImg,
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    TextField(
                      controller: _controller,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          provider.setWeatherData(value);
                        } else {
                          provider.setWeatherData(value);
                        }
                      },
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Color.fromARGB(221, 221, 203, 203),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        hintText: "Enter City Name",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 3, 3, 3)),
                        suffixIconColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, size: 25),
                        Text(
                          provider.weather["city_name"] ?? "Unknown City",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "${provider.weather["temperature"] ?? 'N/A'}°C",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 90,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          provider.weather["main"] ?? 'N/A',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w500),
                        ),
                        Image.asset(
                          provider.iconImg,
                          height: 80,
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward),
                        Text(
                          "${provider.weather["temp_max"] ?? 'N/A'}°C",
                          style: const TextStyle(
                              fontSize: 22, fontStyle: FontStyle.italic),
                        ),
                        const Icon(Icons.arrow_downward),
                        Text(
                          "${provider.weather["temp_min"] ?? 'N/A'}°C",
                          style: const TextStyle(
                              fontSize: 22, fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Card(
                      elevation: 5,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            WeatherData(
                              index1: "Sunrise",
                              value1: "${provider.weather["sunrise"] ?? 'N/A'}",
                              index2: "Sunset",
                              value2: "${provider.weather["sunset"] ?? 'N/A'}",
                            ),
                            const SizedBox(height: 15),
                            WeatherData(
                              index1: "Humidity",
                              value1:
                                  "${provider.weather["humidity"] ?? 'N/A'}",
                              index2: "Visibility",
                              value2:
                                  "${provider.weather["visibility"] ?? 'N/A'}",
                            ),
                            const SizedBox(height: 15),
                            WeatherData(
                              index1: "Pressure",
                              value1:
                                  "${provider.weather["pressure"] ?? 'N/A'}",
                              index2: "Wind speed",
                              value2:
                                  "${provider.weather["wind_speed"] ?? 'N/A'}",
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
