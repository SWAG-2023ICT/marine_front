import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/models/market_price_model.dart';

class UserPriceCard extends StatelessWidget {
  const UserPriceCard({
    super.key,
    required this.marineProduct,
    required this.index,
  });
  final int index;
  final MarketPriceModel marineProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size6,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.4,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            color: Colors.grey.shade400,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${marineProduct.rowNum}. ${marineProduct.mClassName} - ${marineProduct.sClassName}",
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
              Text("[${marineProduct.marketName}]"),
            ],
          ),
          const Divider(),
          Text(
            "가격[최저~최고 {평균}] : ${marineProduct.minPrice} ~ ${marineProduct.maxPrice} {${marineProduct.avgPrice}}",
            // minPrice ~ maxPrice {avgPrice}
            style: const TextStyle(fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("등급 : ${marineProduct.gradeName}"),
              Text("거래량 : ${marineProduct.sumAmt}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "경매일 : ${DateFormat("yyyy-MM-dd").format(marineProduct.dates)}",
                ),
              ),
              Text(
                "도매법인 : ${marineProduct.coName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        ],
      ),
    );
  }
}
