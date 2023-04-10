import 'package:cryptocurrency/core/init/theme/dark_color_scheme/dark_color_scheme.dart';
import 'package:cryptocurrency/product/model/coin_model.dart';
import 'package:cryptocurrency/product/widgets/animated_text/animated_text.dart';
import 'package:cryptocurrency/product/widgets/charts/detail_chart/detail_chart.dart';
import 'package:cryptocurrency/product/widgets/coin_details/coin_details.dart';
import 'package:cryptocurrency/product/widgets/tabbar/custom_tabbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../product/bloc/price/price_bloc.dart';

class DetailView extends StatefulWidget {
  final CoinModel coin;
  const DetailView({super.key, required this.coin});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;
  num currentPrice = 0;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    updateCurrentPrice(widget.coin.currentPrice ?? 0);
    context.read<PriceBloc>().add(FetchPriceEvent(id: widget.coin.id ?? ''));
    super.initState();
  }

  @override
  void deactivate() {
    context.read<PriceBloc>().add(RemovePriceEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name ?? ''),
      ),
      body: Column(
        children: [
          Padding(
            padding: context.paddingLow,
            child: CircleAvatar(
              backgroundColor: DarkColorScheme.instance!.transparent,
              backgroundImage: NetworkImage(widget.coin.image!),
            ),
          ),
          Padding(
            padding: context.paddingLow,
            child: AnimatedText(
                isPriceText: true, value: currentPrice, fontSize: 25),
          ),
          BlocBuilder<PriceBloc, PriceState>(
            builder: (context, state) {
              return AspectRatio(
                aspectRatio: 3 / 1,
                child: DetailChart(
                  spots: getSpotsByIndex(tabController, state),
                  chartColor: getChartColor(tabIndex),
                  lineTouchCallBack: (touchEvent, response) {
                    if (response != null && response.lineBarSpots != null) {
                      updateCurrentPrice(
                        response.lineBarSpots!.first.y,
                      );
                    }
                    if (touchEvent is FlLongPressEnd ||
                        touchEvent is FlPanEndEvent ||
                        touchEvent is FlTapUpEvent) {
                      updateCurrentPrice(
                        widget.coin.currentPrice!,
                      );
                    }
                  },
                ),
              );
            },
          ),
          CustomTabbar(
            onTap: (newIndex) {
              setState(() {
                tabIndex = newIndex;
              });
            },
            tabController: tabController,
          ),
          CoinDetails(coin: widget.coin),
        ],
      ),
    );
  }

  void updateCurrentPrice(num newPrice) {
    setState(() {
      currentPrice = newPrice;
    });
  }

  List<FlSpot> getSpotsByIndex(TabController controller, PriceState state) {
    switch (controller.index) {
      case 0:
        return state.spots1d;
      case 1:
        return state.spots7d;
      case 2:
        return state.spots1m;
      case 3:
        return state.spots3m;
      case 4:
        return state.spots1y;
      default:
        return [];
    }
  }

  Color getChartColor(int tabControllerIndex) {
    switch (tabControllerIndex) {
      case 0:
        return widget.coin.priceChangePercentage24hInCurrency!.isNegative
            ? DarkColorScheme.instance!.chartRed
            : DarkColorScheme.instance!.chartGreen;
      case 1:
        return widget.coin.priceChangePercentage7dInCurrency!.isNegative
            ? DarkColorScheme.instance!.chartRed
            : DarkColorScheme.instance!.chartGreen;
      case 2:
        return widget.coin.priceChangePercentage30dInCurrency!.isNegative
            ? DarkColorScheme.instance!.chartRed
            : DarkColorScheme.instance!.chartGreen;
      case 3:
        return widget.coin.priceChangePercentage30dInCurrency!.isNegative
            ? DarkColorScheme.instance!.chartRed
            : DarkColorScheme.instance!.chartGreen;
      case 4:
        return widget.coin.priceChangePercentage1yInCurrency!.isNegative
            ? DarkColorScheme.instance!.chartRed
            : DarkColorScheme.instance!.chartGreen;
      default:
        return DarkColorScheme.instance!.white;
    }
  }
}
