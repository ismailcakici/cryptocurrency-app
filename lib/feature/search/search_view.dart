import 'package:cryptocurrency/core/init/navigator/routes.dart';
import 'package:cryptocurrency/product/model/coin_model.dart';
import 'package:cryptocurrency/product/repository/coin_repository.dart';
import 'package:cryptocurrency/product/service/coin_service.dart';
import 'package:cryptocurrency/product/widgets/coin_list/coin_list_tile/coin_list_tile.dart';
import 'package:flutter/material.dart';

import '../../product/widgets/search_bar/search_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<CoinModel> searchResults = [];
  late List<CoinModel> coins;
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    getCoinsFromApi();
    super.initState();
  }

  Future<void> getCoinsFromApi() async {
    coins = await CoinRepository(service: CoinService()).getAllCoinsForSearch();
    setState(() {
      coins;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          searchController: searchController,
          onChanged: onChanged,
        ),
      ),
      body: searchResults.isEmpty
          ? const Center(
              child: Text('Please type the coin you are looking for...'),
            )
          : ListView.builder(
              itemCount: searchResults.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return CoinListTile(
                    coin: searchResults[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        detailRoute,
                        arguments: searchResults[index],
                      );
                    });
              },
            ),
    );
  }

  onChanged(String? text) {
    if (text!.isNotEmpty) {
      final suggestions = coins.where((coin) {
        final coinName = coin.name!.toLowerCase();
        final input = text.toLowerCase();
        return coinName.contains(input);
      }).toList();

      setState(() => searchResults = suggestions);
    } else {
      setState(() {
        searchResults.clear();
      });
    }
  }
}
