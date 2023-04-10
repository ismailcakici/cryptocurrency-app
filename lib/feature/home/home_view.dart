import 'package:cryptocurrency/core/init/navigator/routes.dart';
import 'package:cryptocurrency/product/widgets/coin_list/coin_list_builder/coin_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/bloc/coin/coin_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    context.read<CoinBloc>().add(FetchCoins());
    super.initState();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      context.read<CoinBloc>().add(FetchCoins());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchRoute);
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: CoinListBuilder(
        scrollController: scrollController,
      ),
    );
  }
}
