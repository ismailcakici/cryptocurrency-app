part of 'price_bloc.dart';

class PriceState {
  final List<FlSpot> spots1d;
  final List<FlSpot> spots7d;
  final List<FlSpot> spots1m;
  final List<FlSpot> spots3m;
  final List<FlSpot> spots1y;

  const PriceState({
    required this.spots1d,
    required this.spots7d,
    required this.spots1m,
    required this.spots3m,
    required this.spots1y,
  });
}
