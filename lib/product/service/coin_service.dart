import 'dart:convert';

import 'package:http/http.dart' as http;

class CoinService {
  Future<List<dynamic>> fetchAllCoinsForSearch() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h%2C7d%2C30d%2C90d%2C1y&locale=en'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Status Code Error');
    }
  }

  Future<List<dynamic>> fetchCoinList(int page, int perPage) async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$perPage&page=$page&sparkline=true&price_change_percentage=24h%2C7d%2C30d%2C90d%2C1y&locale=en'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Status Code Error');
    }
  }

  Future<List<dynamic>> fetchPrice(String id, int days) async {
    dynamic response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=usd&days=$days'));
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final result = decodedResponse as Map;
      return result.entries.first.value;
    } else {
      throw Exception('Status Code Error');
    }
  }
}
