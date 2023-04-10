import 'package:cryptocurrency/product/model/coin_model.dart';
import 'package:cryptocurrency/product/service/coin_service.dart';
import 'package:fl_chart/fl_chart.dart';

class CoinRepository {
  final CoinService service;

  CoinRepository({required this.service});

  Future<List<CoinModel>> getAllCoinsForSearch() async {
    List<dynamic> result = await service.fetchAllCoinsForSearch();
    return result.map((coins) => CoinModel.fromJson(coins)).toList();
  }

  Future<List<CoinModel>> getCoinList(int page, int perPage) async {
    List<dynamic> result = await service.fetchCoinList(page, perPage);
    return result.map((coins) => CoinModel.fromJson(coins)).toList();
  }

  Future<List<FlSpot>> getSpots(String id, int days) async {
    List<dynamic> rawPrices = await service.fetchPrice(id, days);
    final List<FlSpot> spots = List.generate(rawPrices.length,
        (index) => FlSpot(index.toDouble(), rawPrices[index].last.toDouble()));
    return spots;
  }
}
