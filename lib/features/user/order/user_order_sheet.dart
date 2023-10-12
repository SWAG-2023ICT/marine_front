import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/models/database/price_model.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class UserOrderSheet extends StatefulWidget {
  const UserOrderSheet({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<UserOrderSheet> createState() => _UserOrderSheetState();
}

class _UserOrderSheetState extends State<UserOrderSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  int? _radioValue;
  List<PriceModel>? _priceList;

  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _initPriceList();
  }

  Future<void> _initPriceList() async {
    setState(() {
      _isFirstLoading = true;
    });

    final url =
        Uri.parse("${HttpIp.httpIp}/marine/product/selectAllPriceByProductId");
    final headers = {'Content-Type': 'application/json'};
    final data = {'productId': widget.productId};
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("가게 리스트 호출 : 성공");
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;

      setState(() {
        _priceList =
            jsonResponse.map((data) => PriceModel.fromJson(data)).toList();
      });
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }

    setState(() {
      _isFirstLoading = false;
    });
  }

  Future<void> _onSubmit() async {
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
    context.pop();
    context.pop();
  }

  Future<void> _onOtherSubmit() async {
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
    context.pop();
    context.pop();
  }

  void _onChangePrice(int? changeValue) {
    if (changeValue == null) return;
    setState(() {
      _radioValue = changeValue;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  void _onOrderTap() {
    swagPlatformDialog(
        context: context,
        title: "수신자 알림",
        message: "제품을 받는사람이 본인인가요?",
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              if (Platform.isIOS) {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: const Text(
                      "수신자 변경",
                      style: TextStyle(
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: '수신자 이름(실명)',
                              prefixIcon: Icon(
                                Icons.badge_outlined,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                  11), // 최대 11자리까지 입력 허용
                            ],
                            decoration: InputDecoration(
                              labelText: '수신자 전화번호',
                              prefixIcon: Icon(
                                Icons.phone_iphone_rounded,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: _onOtherSubmit,
                        child: const Text("주문"),
                      )
                    ],
                  ),
                );
              } else if (Platform.isAndroid) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      "수신자 변경",
                      style: TextStyle(
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: '수신자 이름(실명)',
                              prefixIcon: Icon(
                                Icons.badge_outlined,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                  11), // 최대 11자리까지 입력 허용
                            ],
                            decoration: InputDecoration(
                              labelText: '수신자 전화번호',
                              prefixIcon: Icon(
                                Icons.phone_iphone_rounded,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("주문"),
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Text("아니오"),
          ),
          TextButton(
            onPressed: _onSubmit,
            child: const Text("예"),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("주문"),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            onPressed: _isFirstLoading
                ? _radioValue != null
                    ? _onOrderTap
                    : null
                : null,
            child: const Text("주문하기"),
          ),
        ),
        body: _isFirstLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Image.asset(
                        "assets/images/fish.png",
                        width: size.width,
                        height: 250,
                      ),
                    ),
                    SliverList.builder(
                      itemCount: _priceList!.length,
                      itemBuilder: (context, index) => RadioListTile.adaptive(
                        value: _priceList![index].priceId,
                        groupValue: _radioValue,
                        onChanged: _onChangePrice,
                        title: Text("가격 ${index + 1}"),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
