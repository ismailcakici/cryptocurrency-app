import 'package:cryptocurrency/core/init/theme/dark_color_scheme/dark_color_scheme.dart';
import 'package:cryptocurrency/product/model/coin_model.dart';
import 'package:cryptocurrency/product/widgets/animated_text/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CoinDetails extends StatelessWidget {
  final CoinModel coin;
  const CoinDetails({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: context.paddingLow,
        child: Column(
          children: [
            _divider,
            _dataRow('24h High', coin.high24h ?? 0),
            _dividerGrey,
            _dataRow('24h Low', coin.low24h ?? 0),
            _dividerGrey,
            _dataRow('ATH', coin.ath ?? 0),
            _dividerGrey,
            _dataRow('ATL', coin.atl ?? 0),
            _dividerGrey,
            _dataRow('Market Cap', coin.marketCap ?? 0),
            _dividerGrey,
            _dataRow('Total Volume', coin.totalVolume ?? 0),
            _divider,
          ],
        ),
      ),
    );
  }

  Padding _dataRow(String text, num value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('$text  :'),
            AnimatedText(isPriceText: true, value: value, fontSize: 15),
          ],
        ),
      );

  Divider get _divider => Divider(
        color: DarkColorScheme.instance!.white,
        thickness: 1,
      );

  Divider get _dividerGrey => Divider(
        color: DarkColorScheme.instance!.darkGray,
        thickness: 0.5,
      );
}
