class OhlcModel {
  final double open;
  final double high;
  final double low;
  final double close;
  final double volumeTo;

  OhlcModel({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    this.volumeTo = 0,
  });
}
