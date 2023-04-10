import 'package:cryptocurrency/core/init/theme/dark_color_scheme/dark_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kartal/kartal.dart';

class DetailChart extends StatelessWidget {
  final List<FlSpot> spots;
  final Color chartColor;
  final Function(FlTouchEvent touchEvent, LineTouchResponse? response)
      lineTouchCallBack;
  const DetailChart(
      {Key? key,
      required this.spots,
      required this.chartColor,
      required this.lineTouchCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: DarkColorScheme.instance!.transparent,
              getTooltipItems: (touchedSpots) {
                return [LineTooltipItem('', const TextStyle())];
              },
            ),
            touchCallback: lineTouchCallBack,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              dotData: FlDotData(show: false),
              color: chartColor,
              shadow: Shadow(
                  color: chartColor, blurRadius: 8, offset: const Offset(0, 5)),
            ),
          ],
        ),
      ),
    );
  }
}
