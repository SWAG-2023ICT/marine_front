import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/store/menu/store_menu_edit_screen.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class StoreMenuCard extends StatefulWidget {
  const StoreMenuCard({
    super.key,
    required this.image,
  });

  final String image;

  @override
  State<StoreMenuCard> createState() => _StoreMenuCardState();
}

class _StoreMenuCardState extends State<StoreMenuCard> {
  bool _isSelled = true;

  void _onChangeSelled(bool value) {
    setState(() {
      _isSelled = value;
    });
  }

  Future<void> _onDeleteMenu() async {
    if (false) {
      final url = Uri.parse("${HttpIp.httpIp}/");
      final headers = {'Content-Type': 'application/json'};
      final data = {};
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "통신 오류",
          message: response.body,
        );
      }
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
        title: const Text("OOO물고기 / [원산지]"),
        subtitle: const Text("상품 설명..."),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 4,
            ),
            itemBuilder: (context, index) => Row(
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
                  "${100 * (index + 1)}g당",
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
                  "가격 ${(index + 2) * 5000}원",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
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
                      extra: const StoreMenuEditScreenArgs(
                        editType: EditType.update,
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
