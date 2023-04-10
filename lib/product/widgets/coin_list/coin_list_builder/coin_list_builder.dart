import 'package:cryptocurrency/core/init/navigator/routes.dart';
import 'package:cryptocurrency/product/widgets/coin_list/coin_list_tile/coin_list_tile.dart';
import 'package:cryptocurrency/product/widgets/loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/coin/coin_bloc.dart';

class CoinListBuilder extends StatefulWidget {
  final ScrollController scrollController;
  const CoinListBuilder({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<CoinListBuilder> createState() => _CoinListBuilderState();
}

class _CoinListBuilderState extends State<CoinListBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinBloc, CoinState>(
      builder: (context, state) {
        switch (state.status) {
          case CoinStatus.success:
            if (state.coins.isEmpty) {
              return const LoadingIndicator();
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: widget.scrollController,
                itemCount: state.isReachedMax
                    ? state.coins.length
                    : state.coins.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.coins.length
                      ? const LoadingIndicator()
                      : CoinListTile(
                          coin: state.coins[index],
                          onTap: () {
                            Navigator.pushNamed(context, detailRoute,
                                arguments: state.coins[index]);
                          });
                },
              );
            }
          case CoinStatus.failure:
            return const Center(
              child: Text('Error'),
            );
          case CoinStatus.initial:
            return const SizedBox.shrink();
          default:
            return const LoadingIndicator();
        }
      },
    );
  }
}
