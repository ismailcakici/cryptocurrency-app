import 'package:cryptocurrency/core/init/theme/dark_color_scheme/dark_color_scheme.dart';
import 'package:cryptocurrency/product/model/coin_model.dart';
import 'package:cryptocurrency/product/widgets/animated_text/animated_text.dart';
import 'package:cryptocurrency/product/widgets/charts/small_chart/small_chart.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter/material.dart';

class CoinListTile extends StatelessWidget {
  final CoinModel coin;
  final VoidCallback onTap;
  const CoinListTile({Key? key, required this.coin, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(coin.image!),
        backgroundColor: DarkColorScheme.instance!.transparent,
      ),
      title: Text(coin.symbol ?? ''),
      subtitle: Text(coin.name ?? ''),
      trailing: SizedBox(
        width: context.width / 1.8,
        height: context.height / 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AspectRatio(
              aspectRatio: 5 / 2,
              child: SmallChart(
                  spots: coin.sparklineIn7d?.price ?? [],
                  chartColor: coin.priceChangePercentage7dInCurrency == null
                      ? Colors.white
                      : coin.priceChangePercentage7dInCurrency!.isNegative
                          ? DarkColorScheme.instance!.chartRed
                          : DarkColorScheme.instance!.chartGreen),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedText(
                    value: coin.currentPrice ?? 0,
                    isPriceText: true,
                    fontSize: 13),
                AnimatedText(
                    value: coin.priceChangePercentage7dInCurrency ?? 0,
                    isPriceText: false,
                    fontSize: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
