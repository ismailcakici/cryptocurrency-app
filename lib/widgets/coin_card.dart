import 'package:crypto_app/theme/colors.dart';
import 'package:crypto_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final VoidCallback callback;
  final String? symbol;
  final String? name;
  final String? image;
  final double? currentPrice;
  final double? priceChangePercentage_24h;
  const CoinCard(
      {Key? key,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.priceChangePercentage_24h,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        shadowColor: MyColors.white300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: MyColors.white200,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(image!),
          ),
          title: Text(
            name!,
            style: MyTextStyle.poppinsBold20.copyWith(color: MyColors.grey300),
          ),
          subtitle: Text(
            symbol!,
            style: MyTextStyle.poppinsBold14.copyWith(color: MyColors.grey),
          ),
          onTap: callback,
          trailing: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${currentPrice!}",
                      style: MyTextStyle.poppinsRegular20
                          .copyWith(color: MyColors.grey200),
                    ),
                    Text(
                      "%${priceChangePercentage_24h!.toStringAsFixed(2)}",
                      style: MyTextStyle.poppinsRegular14.copyWith(
                          color: priceChangePercentage_24h! > 0
                              ? MyColors.green
                              : MyColors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
