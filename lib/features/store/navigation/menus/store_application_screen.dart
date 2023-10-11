import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class StoreApplicationScreen extends StatefulWidget {
  const StoreApplicationScreen({super.key});

  @override
  State<StoreApplicationScreen> createState() => _StoreApplicationScreenState();
}

class _StoreApplicationScreenState extends State<StoreApplicationScreen> {
  bool _isFirstLoading = false;
  List<dynamic>? _applicationList;

  @override
  void initState() {
    super.initState();

    // _initDispatch();
  }

  Future<void> _initDispatch() async {
    setState(() {
      _isFirstLoading = true;
    });

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

    setState(() {
      _isFirstLoading = false;
    });
  }

  Future<void> _refreshDispatch() async {
    setState(() {
      _isFirstLoading = true;
    });

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

    setState(() {
      _isFirstLoading = false;
    });
  }

  Future<void> _onRequestAccept() async {
    Future<void> _refreshDispatch() async {
      setState(() {
        _isFirstLoading = true;
      });

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

      setState(() {
        _isFirstLoading = false;
      });
    }
  }

  Future<void> _onRequestRefusal() async {
    Future<void> _refreshDispatch() async {
      setState(() {
        _isFirstLoading = true;
      });

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

      setState(() {
        _isFirstLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        title: const Text("신청"),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              "assets/images/sea4.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          _isFirstLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : RefreshIndicator.adaptive(
                  onRefresh: _refreshDispatch,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 0.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2, 2),
                              blurRadius: 1,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                        child: ExpansionTile(
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          childrenPadding: const EdgeInsets.all(10),
                          title: const Text(
                            "[주소] 진주시 가좌동 어쩌구저쩌구 000동 000호",
                            style: TextStyle(fontSize: 18),
                          ),
                          children: [
                            const Text(
                              "[주문] OOO물고기",
                              style: TextStyle(fontSize: 16),
                            ),
                            Gaps.v4,
                            const Text(
                              "[개수] 100g 2개",
                              style: TextStyle(fontSize: 16),
                            ),
                            Gaps.v4,
                            const Text(
                              "[이름] OOO",
                              style: TextStyle(fontSize: 16),
                            ),
                            Gaps.v4,
                            const Text(
                              "[연락처] 01012345678",
                              style: TextStyle(fontSize: 16),
                            ),
                            Gaps.v4,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: _onRequestRefusal,
                                  child: const Text("거부"),
                                ),
                                Gaps.h10,
                                ElevatedButton(
                                  onPressed: _onRequestAccept,
                                  child: const Text("수락"),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
