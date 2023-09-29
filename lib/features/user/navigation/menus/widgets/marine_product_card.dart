import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/models/marine_product.dart';

class MarineProductCard extends StatelessWidget {
  const MarineProductCard({
    super.key,
    required this.marineProduct,
    required this.index,
  });
  final int index;
  final MarineProduct marineProduct;

  String _sumParsing(double value) {
    return value == value.floor() ? value.toInt().toString() : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size6,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${index + 1}. ${marineProduct.mClassName} - ${marineProduct.sClassName}",
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
            "가격(저~고 {평균}) : ${_sumParsing(marineProduct.minPrice)} ~ ${_sumParsing(marineProduct.maxPrice)} {${_sumParsing(marineProduct.avgPrice)}}",
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
              Text("경매일 : ${marineProduct.dates}"),
              Text("도매법인 : ${marineProduct.coName}")
            ],
          )
        ],
      ),
    );
  }
}
