import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/user/order/user_order_sheet.dart';
import 'package:swag_marine_products/models/database/product_model.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.storeId,
    required this.productData,
  });

  final String storeId;
  final ProductModel productData;

  void _onProductTap(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => UserOrderSheet(
        storeId: storeId,
        productData: productData,
      ),
      useSafeArea: true,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: productData.productStatus ? () => _onProductTap(context) : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: productData.productStatus ? 1 : 0.5,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                // border: Border(
                //   top: BorderSide(
                //     width: 0.5,
                //   ),
                //   bottom: BorderSide(
                //     width: 0.5,
                //   ),
                // ),
              ),
              child: Row(
                children: [
                  Image.memory(
                    productData.productImage!,
                    width: 75,
                    height: 75,
                    fit: BoxFit.fill,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productData.productName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gaps.v6,
                          Text(
                            "원산지 : ${productData.origin}/${productData.cultivationType == 1 ? "자연산" : "양식"}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Gaps.v6,
                          Text(
                            "상세내용 : ${productData.description}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!productData.productStatus)
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: const Text(
                "판매 마감",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
