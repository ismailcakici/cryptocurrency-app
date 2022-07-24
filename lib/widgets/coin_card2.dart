import 'package:crypto_app/theme/colors.dart';
import 'package:crypto_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'coin_chart.dart';

class CoinCard2 extends StatefulWidget {
  final VoidCallback callback;
  final String? symbol;
  final String? name;
  final String? image;
  final double? currentPrice;
  final double? priceChangePercentage_24h;
  final int? high_24h;
  final int? low_24h;
  final int? ath;
  const CoinCard2(
      {Key? key,
      required this.callback,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.priceChangePercentage_24h,
      this.high_24h,
      this.low_24h,
      this.ath})
      : super(key: key);

  @override
  State<CoinCard2> createState() => _CoinCard2State();
}

class _CoinCard2State extends State<CoinCard2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: InkWell(
        onTap: widget.callback,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.6,
          child: Card(
            elevation: 3,
            shadowColor: MyColors.grey200,
            color: MyColors.white200,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                      child: Image.network(
                        widget.image!,
                      ),
                    ),
                    Text(
                      widget.name!,
                      style: MyTextStyle.poppinsBold16,
                    ),
                    Flexible(
                      child: Text(
                        "\$${widget.currentPrice!.toDouble()}",
                        style: MyTextStyle.poppinsRegular16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "%${widget.priceChangePercentage_24h!.toStringAsFixed(2)}",
                      style: MyTextStyle.poppinsRegular16.copyWith(
                          color: widget.priceChangePercentage_24h! > 0
                              ? MyColors.green
                              : MyColors.red),
                    )
                  ],
                ),
                Flexible(
                  child: LineChartSample2(
                    ath: widget.ath!.toDouble(),
                    currentPrice: widget.currentPrice,
                    high_24h: widget.high_24h!.toDouble(),
                    low_24h: widget.low_24h!.toDouble(),
                    priceChangePercentage_24h: widget.priceChangePercentage_24h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
