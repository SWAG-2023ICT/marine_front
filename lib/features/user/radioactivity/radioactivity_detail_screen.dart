import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:swag_marine_products/models/radioactivity_list_model.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

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
  List<RadioactivityListModel>? _originallistData;
  List<RadioactivityListModel>? _listData;

  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();

  bool _isBarriered = false;
  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _initListData();
  }

  Future<void> _initListData() async {
    setState(() {
      _isFirstLoading = true;
    });
    final url =
        Uri.parse("https://www.nfqs.go.kr/hpmg/front/api/smp_ra_api.do");
    final data = {
      'cert_key':
          'F8DF6E07AB34174E3C3FC262ECAD4EBDAA189FA70D7B94D468F0B6DD92DC8C20',
      'start_dt': DateFormat('yyyyMMdd').format(_startDate),
      'end_dt': DateFormat('yyyyMMdd').format(_endDate),
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final xmlData = XmlDocument.parse(response.body);
      print(xmlData);

      final items = xmlData.findAllElements('item');
      final List<RadioactivityListModel> dataList = [];

      for (final item in items) {
        final itmNm = item.findElements('itmNm').first.innerText;
        final gathDt =
            DateTime.parse(item.findElements('gathDt').first.innerText);
        final ogLoc = item.findElements('ogLoc').first.innerText;
        final analMchnNm = item.findElements('analMchnNm').first.innerText;
        final charPsngVal = item.findElements('charPsngVal').first.innerText;

        final itemData = RadioactivityListModel(
          itmNm: itmNm,
          gathDt: gathDt,
          ogLoc: ogLoc,
          analMchnNm: analMchnNm,
          charPsngVal: charPsngVal,
        );

        dataList.add(itemData);
      }

      setState(() {
        _originallistData = dataList; // _listData에 데이터 저장
        _listData = dataList; // _listData에 데이터 저장
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

  void _onSearch() {
    setState(() {
      _isFirstLoading = true;
    });
    final searchText = _searchController.text.toLowerCase();

    // 검색어가 빈 문자열이면 모든 항목을 표시
    if (searchText.isEmpty) {
      _initListData();
      return;
    }

    final filteredList = _originallistData!.where((item) {
      // 검색어가 항목에 포함되어 있는지 확인
      final itemName = item.itmNm.toLowerCase();
      final itemLocation = item.ogLoc.toLowerCase();
      return itemName.contains(searchText) || itemLocation.contains(searchText);
    }).toList();

    setState(() {
      _listData = filteredList;
      _isFirstLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
            onPressed: _onSearch,
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
          RefreshIndicator.adaptive(
            onRefresh: _initListData,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  surfaceTintColor: Colors.transparent,
                  pinned: true,
                  titleTextStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          '${DateFormat('yyyy-MM-dd').format(_startDate)} ~ ${DateFormat('yyyy-MM-dd').format(_endDate)}'),
                      ElevatedButton(
                        onPressed: () async {
                          final date = await showDateRangePicker(
                            context: context,
                            initialDateRange:
                                DateTimeRange(start: _startDate, end: _endDate),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate: DateTime.now(),
                          );

                          print(date?.start);
                          print(date?.end);
                          if (date != null) {
                            setState(() {
                              _startDate = date.start;
                              _endDate = date.end;
                            });
                            _initListData();
                          }
                        },
                        child: const Text("날짜 변경"),
                      )
                    ],
                  ),
                ),
                _isFirstLoading
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )
                    : SliverList.builder(
                        itemCount: _listData!.length,
                        // separatorBuilder: (context, index) => Gaps.v10,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(1, 1),
                                  blurRadius: 1,
                                  color: Colors.grey.shade400,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _listData![index].ogLoc.trim().isEmpty
                                          ? "[${_listData![index].itmNm}]"
                                          : "[${_listData![index].itmNm} / ${_listData![index].ogLoc}]",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    _listData![index].charPsngVal == "불검출"
                                        ? Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: const Text(
                                              "불검출",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: Colors.red,
                                            child: const Text("검출"),
                                          ),
                                  ],
                                ),
                                const Divider(),
                                Text(
                                  "채취일자 : ${DateFormat('yyyy-MM-dd').format(_listData![index].gathDt)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "검사지원 : ${_listData![index].analMchnNm}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
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
