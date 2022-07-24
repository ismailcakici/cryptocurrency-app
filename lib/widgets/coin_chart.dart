import 'package:crypto_app/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  final double? priceChangePercentage_24h;
  final double? currentPrice;
  final double? high_24h;
  final double? low_24h;
  final double? ath;
  const LineChartSample2(
      {Key? key,
      this.currentPrice,
      this.high_24h,
      this.low_24h,
      this.ath,
      this.priceChangePercentage_24h})
      : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColorsGreen = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  List<Color> gradientColorsRed = [
    MyColors.red,
    Colors.orange,
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: widget.ath,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, widget.low_24h!),
            FlSpot(2, widget.currentPrice!),
            FlSpot(3, widget.ath!),
            FlSpot(4, widget.high_24h!),
            FlSpot(5, widget.currentPrice!),
            FlSpot(6, widget.low_24h!),
            FlSpot(8, widget.ath!),
            FlSpot(10, widget.currentPrice!),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: widget.priceChangePercentage_24h! > 0
                ? gradientColorsGreen
                : gradientColorsRed,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: widget.priceChangePercentage_24h! > 0
                  ? gradientColorsGreen
                      .map((color) => color.withOpacity(0.3))
                      .toList()
                  : gradientColorsRed
                      .map((color) => color.withOpacity(0.3))
                      .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
