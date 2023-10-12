import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/user/order/user_order_screen.dart';
import 'package:swag_marine_products/models/database/store_model.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    super.key,
    required this.storeData,
  });

  final StoreModel storeData;

  void _onTapStore(BuildContext context) {
    context.pushNamed(
      UserOrderScreen.routeName,
      extra: UserOrderScreenArgs(
        storeId: storeData.storeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.all(6),
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
      // child: ListTile(
      //   contentPadding: EdgeInsets.zero,
      //   leading: Image.asset(
      //     "assets/images/fishShop.png",
      //   ),
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       const Text(
      //         "[가게 이름]",
      //         style: TextStyle(
      //           fontSize: 16,
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: const Icon(Icons.favorite_outline),
      //       ),
      //     ],
      //   ),
      //   subtitle: const Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Divider(),
      //       Text("가게 주소 : ${"진주시 가좌동"}"),
      //       Text("가게 번호 : ${"010-0000-0000"}"),
      //     ],
      //   ),
      // ),
      child: InkWell(
        onTap: () => _onTapStore(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/fishShop.png",
              width: 100,
              height: 100,
            ),
            Gaps.h6,
            // const Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Expanded(
            //             child: Text(
            //               "[가게 이름]",
            //               maxLines: 1,
            //               style: TextStyle(
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Divider(),
            //       Text("가게 주소 : ${"진주시 가좌동"}"),
            //       Text("가게 번호 : ${"010-0000-0000"}"),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "[${storeData.storeName}]",
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Text("가게 주소 : ${storeData.storeAddress}"),
                  Text("가게 번호 : ${storeData.storePhoneNumber}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
