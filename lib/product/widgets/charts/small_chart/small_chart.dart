import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SmallChart extends StatelessWidget {
  final List<double> spots;
  final Color chartColor;
  const SmallChart({Key? key, required this.spots, required this.chartColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show : false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(spots.length, (index) => FlSpot(index.toDouble(), spots[index])),
            dotData: FlDotData(show: false),
            color: chartColor,
            shadow: Shadow(
              color: chartColor,
              blurRadius: 5
            ),
          ),
        ],
      ),
    );
  }
}
