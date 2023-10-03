import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/models/radioactivity_banner_model.dart';
import 'package:xml/xml.dart';

import 'package:http/http.dart' as http;
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class RadioactivityBanner extends StatefulWidget {
  const RadioactivityBanner({Key? key}) : super(key: key);

  @override
  State<RadioactivityBanner> createState() => _RadioactivityBannerState();
}

class _RadioactivityBannerState extends State<RadioactivityBanner> {
  late RadioactivityBannerModel _bannerData;

  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void initBannerData() async {
    setState(() {
      _isFirstLoading = true;
    });
    final url = Uri.parse(
        "https://www.nfqs.go.kr/hpmg/front/api/radioactivity/DailyRslt.do");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'cert_key':
          '5F387470A18F43DEE7BEDB222FA91C524B6BB02A1711FDD4902AB163828DADEA'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final xmlData = XmlDocument.parse(response.body);

      final dailyDate = xmlData.findAllElements('dailyDate').toString() ?? '';
      final dailyPassCnt =
          xmlData.findAllElements('dailyPassCnt').toString() ?? '0';
      final dailyFailCnt =
          xmlData.findAllElements('dailyFailCnt').toString() ?? '0';
      final dailyTotCnt =
          xmlData.findAllElements('dailyTotCnt').toString() ?? '0';

      setState(() {
        final bannerData = RadioactivityBannerModel(
          dailyDate: DateTime.parse(dailyDate),
          dailyPassCnt: dailyPassCnt as int,
          dailyFailCnt: dailyFailCnt as int,
          dailyTotCnt: dailyTotCnt as int,
        );
      });
    } else {
      swagPlatformDialog(
        context: context,
        title: "통신 오류",
        message: "방사능 결과를 받아오지 못했습니다",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              "알겠습니다",
            ),
          ),
        ],
      );
    }

    setState(() {
      _isFirstLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, // 그림자 색상
            offset: Offset(1.5, 1.5), // 그림자 위치 (가로, 세로)
            blurRadius: 5, // 그림자의 흐림 정도
            spreadRadius: 0, // 그림자 확산 정도
          ),
        ],
      ),
      child: _isFirstLoading
          ? const CircularProgressIndicator.adaptive()
          : ExpansionTile(
              initiallyExpanded: true,
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              collapsedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              title: Row(
                children: [
                  Image.asset(
                    "assets/images/radioactivity.png",
                    width: 16,
                    height: 16,
                  ),
                  Gaps.h6,
                  const Text(
                    "수산물 일일 방사능 검사결과",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Text("[${_bannerData.dailyDate}]"),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: Sizes.size8,
                    left: Sizes.size8,
                    right: Sizes.size8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RadioactivityCard(
                        title: "전체 건 수",
                        num: _bannerData.dailyTotCnt,
                      ),
                      RadioactivityCard(
                        title: "적합 건 수",
                        num: _bannerData.dailyPassCnt,
                        isNumBold: true,
                        numColor: Colors.blue,
                      ),
                      RadioactivityCard(
                        title: "부적합 건 수",
                        num: _bannerData.dailyFailCnt,
                        isNumBold: true,
                        numColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class RadioactivityCard extends StatelessWidget {
  const RadioactivityCard({
    super.key,
    required this.title,
    required this.num,
    this.isNumBold = false,
    this.numColor = Colors.black,
  });

  final String title;
  final int num;
  final bool isNumBold;
  final Color numColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.size10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.6,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            num.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: isNumBold ? FontWeight.bold : FontWeight.normal,
              color: num == 0 ? Colors.grey : numColor,
            ),
          ),
        ],
      ),
    );
  }
}
