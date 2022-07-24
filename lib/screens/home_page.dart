import 'dart:convert';
import 'package:crypto_app/model/coin_model.dart';
import 'package:crypto_app/screens/detail_page.dart';
import 'package:crypto_app/screens/search_page.dart';
import 'package:crypto_app/theme/colors.dart';
import 'package:crypto_app/theme/text_theme.dart';
import 'package:crypto_app/widgets/coin_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/coin_card2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      drawer: const Drawer(),
      appBar: appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topCoinsText("Recent"),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10, right: 10),
              itemCount: coinModel.length,
              itemBuilder: (context, index) {
                return CoinCard2(
                  ath: coinModel[index].ath,
                  high_24h: coinModel[index].high_24h,
                  low_24h: coinModel[index].low_24h,
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
                  currentPrice: coinModel[index].currentPrice,
                  image: coinModel[index].image,
                  name: coinModel[index].name,
                  priceChangePercentage_24h:
                      coinModel[index].priceChangePercentage_24h,
                  symbol: coinModel[index].symbol,
                );
              },
            ),
          ),
          topCoinsText("Top Coins"),
          listViewBuilder(),
        ],
      ),
    );
  }

  Padding topCoinsText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 18),
      child: Text(
        text,
        style: MyTextStyle.poppinsBold26.copyWith(color: MyColors.grey300),
      ),
    );
  }

  Expanded listViewBuilder() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: coinModel.length,
        itemBuilder: (context, index) {
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
            image: coinModel[index].image,
            currentPrice: coinModel[index].currentPrice!,
            name: coinModel[index].name,
            symbol: coinModel[index].symbol,
            priceChangePercentage_24h:
                coinModel[index].priceChangePercentage_24h,
          );
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SearchPage(),
                  ));
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ],
      title: const Text("CoinList"),
    );
  }
}
