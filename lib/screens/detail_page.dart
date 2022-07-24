import 'package:crypto_app/theme/colors.dart';
import 'package:crypto_app/theme/text_theme.dart';
import 'package:crypto_app/widgets/coin_chart.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String? id;
  final String? symbol;
  final String? name;
  final String? image;
  final double? currentPrice;
  final int? high_24h;
  final int? low_24h;
  final int? ath;
  final double? priceChangePercentage_24h;
  const DetailPage(
      {Key? key,
      this.id,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.high_24h,
      this.low_24h,
      this.ath,
      this.priceChangePercentage_24h})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                height: MediaQuery.of(context).size.height / 6,
                widget.image!,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: LineChartSample2(
                ath: widget.ath!.toDouble(),
                currentPrice: widget.currentPrice,
                high_24h: widget.high_24h!.toDouble(),
                low_24h: widget.low_24h!.toDouble(),
                priceChangePercentage_24h: widget.priceChangePercentage_24h,
              ),
            ),
            Text(
              "Current Price : \$${widget.currentPrice}",
              style: MyTextStyle.poppinsRegular20,
            ),
            Text(
              "Low 24h : \$${widget.low_24h}",
              style: MyTextStyle.poppinsRegular20,
            ),
            Text(
              "High 24h : \$${widget.high_24h}",
              style: MyTextStyle.poppinsRegular20,
            ),
            Text(
              "Ath : \$${widget.ath}",
              style: MyTextStyle.poppinsRegular20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price Percentage : ",
                  style: MyTextStyle.poppinsRegular20,
                ),
                Text(
                  "%${widget.priceChangePercentage_24h}",
                  style: MyTextStyle.poppinsRegular20.copyWith(
                      color: widget.priceChangePercentage_24h! > 0
                          ? MyColors.green
                          : MyColors.red),
                ),
              ],
            ),
            Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: MyColors.white,
                          primary: MyColors.green,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Buy",
                          style: MyTextStyle.poppinsBold24,
                        )),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          onPrimary: MyColors.white,
                          primary: MyColors.red,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Sell",
                          style: MyTextStyle.poppinsBold24,
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
