import 'dart:convert';

import 'package:crypto_app/model/coin_model.dart';
import 'package:crypto_app/widgets/coin_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../theme/colors.dart';
import '../theme/text_theme.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<CoinModel> coinModel = [];
  @override
  void initState() {
    super.initState();
    _getDataFromApi();
  }

  void _getDataFromApi() async {
    var response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"));
    setState(() {
      List<dynamic> values = [];
      values = jsonDecode(response.body);
      for (var i = 0; i < values.length; i++) {
        Map<String, dynamic> map = values[i];
        coinModel.add(CoinModel.fromJson(map));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          autoCompleteWidget(context),
        ],
      ),
    );
  }

  Autocomplete<CoinModel> autoCompleteWidget(BuildContext context) {
    return Autocomplete<CoinModel>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) {
          return List.empty();
        }
        return coinModel
            .where((element) =>
                element.name!.toLowerCase().contains(value.text.toLowerCase()))
            .toList()
            .whereType();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
              FocusNode node, Function onSubmit) =>
          Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: MyColors.grey400)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: MyColors.grey400)),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  controller.clear();
                });
              },
              icon: const Icon(Icons.clear),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Search Coin...",
          ),
          controller: controller,
          focusNode: node,
          style: MyTextStyle.poppinsBold14,
        ),
      ),
      optionsViewBuilder: (BuildContext context, Function onSelect,
          Iterable<CoinModel> myCoinList) {
        return Material(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: myCoinList.length,
            itemBuilder: (BuildContext context, index) {
              CoinModel coin = myCoinList.elementAt(index);
              return CoinCard(
                callback: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => DetailPage(
                          priceChangePercentage_24h:
                              coinModel[index].priceChangePercentage_24h,
                          ath: coinModel[index].ath,
                          currentPrice: coinModel[index].currentPrice,
                          high_24h: coinModel[index].high_24h,
                          id: coinModel[index].id,
                          image: coinModel[index].image,
                          low_24h: coinModel[index].low_24h,
                          name: coinModel[index].name,
                          symbol: coinModel[index].symbol,
                        ),
                      ));
                },
                image: coin.image,
                currentPrice: coin.currentPrice!,
                name: coin.name,
                symbol: coin.symbol,
                priceChangePercentage_24h: coin.priceChangePercentage_24h,
              );
            },
          ),
        );
      },
      optionsMaxHeight: MediaQuery.of(context).size.height,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Search Coin"),
    );
  }
}
