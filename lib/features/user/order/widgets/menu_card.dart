import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/user/order/user_order_sheet.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.image,
  });

  final String image;

  void _onProductTap(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => const UserOrderSheet(),
      useSafeArea: true,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onProductTap(context),
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
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OOO물고기",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v6,
                    Text(
                      "최저 가격 : ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "원산지 : ",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Image.asset(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
