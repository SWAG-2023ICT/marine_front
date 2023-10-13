import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/store/menu/store_menu_edit_screen.dart';
import 'package:swag_marine_products/models/database/product_model.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class StoreMenuCard extends StatefulWidget {
  const StoreMenuCard({
    super.key,
    required this.image,
    required this.productData,
    required this.initStoreData,
  });

  final String image;
  final ProductModel productData;
  final Function initStoreData;

  @override
  State<StoreMenuCard> createState() => _StoreMenuCardState();
}

class _StoreMenuCardState extends State<StoreMenuCard> {
  bool _isSelled = true;

  @override
  void initState() {
    super.initState();

    _isSelled = widget.productData.productStatus;
  }

  void _onChangeSelled(bool value) async {
    final url =
        Uri.parse("${HttpIp.httpIp}/marine/product/updateProductStatus");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'productId': widget.productData.productId,
      'productStatus': value,
    };
    final response =
        await http.put(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("제품 판매 여부 변경 : 성공");

      setState(() {
        _isSelled = value;
      });
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }
  }

  Future<void> _onDeleteMenu() async {
    final url = Uri.parse("${HttpIp.httpIp}/marine/product/deleteProduct");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'prices':
          widget.productData.prices.map((e) => {'priceId': e.priceId}).toList(),
      'productId': widget.productData.productId,
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("제품 삭제 : 성공");
      context.pop();
      widget.initStoreData();
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          side: BorderSide(
            width: 0.5,
          ),
        ),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          side: BorderSide(
            width: 0.5,
          ),
        ),
        leading: Image.asset(
          widget.image,
          width: 50,
          fit: BoxFit.fill,
        ),
        title: Text(
            "${widget.productData.productName} / [${widget.productData.origin}]"),
        subtitle: Text(widget.productData.description),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.productData.prices.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 4,
            ),
            itemBuilder: (context, index) {
              final item = widget.productData.prices[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${index + 1}.",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "-",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${item.unit}당",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "-",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${NumberFormat.currency(locale: 'ko_KR', symbol: '').format(item.priceByUnit)}원",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: SwitchListTile.adaptive(
                    value: _isSelled,
                    onChanged: _onChangeSelled,
                    title: const Text(
                      "판매 여부",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      StoreMenuEditScreen.routeName,
                      extra: StoreMenuEditScreenArgs(
                        editType: EditType.update,
                        productData: widget.productData,
                      ),
                    );
                  },
                  child: const Text("수정"),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {
                    swagPlatformDialog(
                      context: context,
                      title: "삭제 알림",
                      message: "정말로 해당 상품을 삭제하시겠습니까?",
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text("아니오"),
                        ),
                        TextButton(
                          onPressed: _onDeleteMenu,
                          child: const Text("예"),
                        ),
                      ],
                    );
                  },
                  child: const Text("삭제"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
