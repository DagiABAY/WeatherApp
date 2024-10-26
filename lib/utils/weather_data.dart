import 'package:flutter/material.dart';

class WeatherData extends StatelessWidget {
  final String index1;
  final String value1;
  final String index2;
  final String value2;
  WeatherData({
    super.key,
    required this.index1,
    required this.value1,
    required this.index2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              index1,
              style: indexStyle,
            ),
            Text(
              index2,
              style: indexStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              value1,
              style: valueStyle,
            ),
            Text(
              value2,
              style: valueStyle,
            ),
          ],
        ),
      ],
    );
  }

  TextStyle indexStyle = const TextStyle(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500);

  TextStyle valueStyle = const TextStyle(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300);
}
