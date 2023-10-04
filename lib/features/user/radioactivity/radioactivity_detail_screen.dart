import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class RadioactivityDetailScreen extends StatefulWidget {
  static const routeName = "radioactivityDetail";
  static const routeURL = "radioactivityDetail";
  const RadioactivityDetailScreen({super.key});

  @override
  State<RadioactivityDetailScreen> createState() =>
      _RadioactivityDetailScreenState();
}

class _RadioactivityDetailScreenState extends State<RadioactivityDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isBarriered = false;

  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _initBannerData();
  }

  void _initBannerData() async {
    setState(() {
      _isFirstLoading = true;
    });
    final url = Uri.parse(
        "https://www.nfqs.go.kr/hpmg/front/api/radioactivityDailyRslt.do");
    final headers = {
      'Content-Type': 'application/json',
    };
    final data = {
      'cert_key':
          '5F387470A18F43DEE7BEDB222FA91C524B6BB02A1711FDD4902AB163828DADEA',
      'inspType': '01',
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final xmlData = XmlDocument.parse(response.body);
      print(xmlData);

      // xmlData의 데이터를 RadioactivityBannerModel.fromJson으로 파싱하는 작업 추가
      final dailyDate = xmlData.findAllElements('dailyDate').first.innerText;
      final dailyPassCnt =
          xmlData.findAllElements('dailyPassCnt').first.innerText;
      final dailyFailCnt =
          xmlData.findAllElements('dailyFailCnt').first.innerText;
      final dailyTotCnt =
          xmlData.findAllElements('dailyTotCnt').first.innerText;

      print(dailyDate);
      print(dailyPassCnt);
      print(dailyFailCnt);
      print(dailyTotCnt);

      final itemData = RadioactivityBannerModel(
        dailyDate: DateTime.parse(dailyDate),
        dailyPassCnt: int.parse(dailyPassCnt),
        dailyFailCnt: int.parse(dailyFailCnt),
        dailyTotCnt: int.parse(dailyTotCnt),
      );

      setState(() {
        _bannerData = itemData;
      });
    } else {
      if (!mounted) return;
      swagPlatformDialog(
        context: context,
        title: "통신 오류",
        message:
            "방사능 리스트를 받아오지 못했습니다 ${response.statusCode} : ${response.body}",
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
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          onTap: () {
            setState(() {
              _isBarriered = true;
            });
          },
          decoration: const InputDecoration(
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(18),
              textStyle: const TextStyle(fontSize: 14),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            child: const Text("검색"),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(),
          if (_isBarriered)
            ModalBarrier(
              // color: _barrierAnimation,
              color: Colors.transparent,
              // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
              dismissible: true,
              // 자신을 클릭하면 실행되는 함수
              onDismiss: () {
                setState(() {
                  _isBarriered = false;
                  FocusScope.of(context).unfocus();
                });
              },
            ),
        ],
      ),
    );
  }
}
