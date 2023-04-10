import 'package:cryptocurrency/core/init/navigator/routes.dart';
import 'package:cryptocurrency/feature/detail/detail_view.dart';
import 'package:cryptocurrency/feature/home/home_view.dart';
import 'package:cryptocurrency/feature/search/search_view.dart';
import 'package:cryptocurrency/product/model/coin_model.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchView());
      case detailRoute:
        Object? coin = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => DetailView(coin: coin as CoinModel));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
