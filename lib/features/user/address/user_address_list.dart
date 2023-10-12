import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/features/user/address/user_address_edit.dart';
import 'package:swag_marine_products/models/database/destination_model.dart';
import 'package:swag_marine_products/providers/user_provider.dart';
import 'package:swag_marine_products/storages/address_storage.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class UserAddressList extends StatefulWidget {
  const UserAddressList({Key? key}) : super(key: key);

  @override
  State<UserAddressList> createState() => _UserAddressListState();
}

class _UserAddressListState extends State<UserAddressList> {
  int? _addressRadio;
  int? _addressDefault;
  bool _isFirstLoading = false;

  List<DestinationModel> _addressList = [];

  @override
  void initState() {
    super.initState();

    _initAddressList();
  }

  Future<void> _initAddressList() async {
    setState(() {
      _isFirstLoading = true;
    });

    final url = Uri.parse(
        "${HttpIp.httpIp}/marine/users/${context.read<UserProvider>().userId}");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("유저 주소 호출 : 성공");
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final destinationsList = jsonResponse["destinations"] as List<dynamic>;

      setState(() {
        _addressList = destinationsList.map((data) {
          if (data["defaultStatus"]) {
            _addressRadio = data["destinationId"];
            _addressDefault = data["destinationId"];
          }
          return DestinationModel.fromJson(data);
        }).toList();
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

  void _onClickAddButton() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => const UserAddressEdit(
        editType: AddressEditType.add,
      ),
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );

    _initAddressList();
  }

  void _onClickUpdateButton(DestinationModel value) async {
    final address = value.destinationAddress.split(",");

    if (address.length == 2) {
      await showModalBottomSheet(
        context: context,
        builder: (context) => UserAddressEdit(
          editType: AddressEditType.update,
          addressId: value.destinationId,
          addressKey: value.destinationName,
          addressValue: address[0],
          addressDetail: address[1],
        ),
        useSafeArea: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
    } else if (address.length == 1) {
      await showModalBottomSheet(
        context: context,
        builder: (context) => UserAddressEdit(
          editType: AddressEditType.update,
          addressId: value.destinationId,
          addressKey: value.destinationName,
          addressValue: address[0],
        ),
        useSafeArea: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
    } else {
      swagPlatformDialog(
        context: context,
        title: "주소 오류",
        message: "주소의 이름이 이상합니다!",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다"),
          ),
        ],
      );
    }

    _initAddressList();
  }

  void _onClickDeleteButton(DestinationModel value) async {
    if (_addressList.length == 1) {
      swagPlatformDialog(
        context: context,
        title: "삭제 알림",
        message: "주소가 한개만 남았을때는 삭제할 수 없습니다!",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다"),
          ),
        ],
      );
    } else if (value.defaultStatus) {
      swagPlatformDialog(
        context: context,
        title: "삭제 알림",
        message: "현재 적용중인 주소는 삭제할 수 없습니다!",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다"),
          ),
        ],
      );
    } else {
      setState(() {
        _isFirstLoading = true;
      });

      final url =
          Uri.parse("${HttpIp.httpIp}/marine/destination/deleteDestination");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        'destinationId': value.destinationId,
      };
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("주소 삭제 : 성공");

        _initAddressList();
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
  }

  void _onClickApplyButton() async {
    if (_addressDefault == _addressRadio) {
      swagPlatformDialog(
        context: context,
        title: "변경 오류",
        message: "이미 대표 주소로 선택되어 있습니다.",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다."),
          ),
        ],
      );
    } else {
      setState(() {
        _isFirstLoading = true;
      });

      final url =
          Uri.parse("${HttpIp.httpIp}/marine/destination/updateDefaultStatus");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        'destinations': [
          {'destinationId': _addressDefault},
          {'destinationId': _addressRadio},
        ],
      };
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("주소 기본 배송지 변경 : 성공");

        _initAddressList();
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
  }

  Future<void> _onRefresh() async {
    _initAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: _onRefresh,
      child: Column(
        children: [
          const CenteredDivider(text: "주소 리스트"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 32,
                  onPressed: _onRefresh,
                  icon: const Icon(Icons.refresh_outlined),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _onClickAddButton,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        textStyle: const TextStyle(fontSize: 14),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text("추가"),
                    ),
                    Gaps.h10,
                    ElevatedButton(
                      onPressed: _onClickApplyButton,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        textStyle: const TextStyle(fontSize: 14),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text("적용"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _isFirstLoading
              ? const CircularProgressIndicator.adaptive()
              : _addressList.isEmpty
                  ? Center(
                      child: IconButton(
                        iconSize: MediaQuery.of(context).size.width / 3,
                        color: Colors.grey.shade400,
                        icon: const Icon(Icons.refresh_outlined),
                        onPressed: _onRefresh,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _addressList.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Gaps.v6,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: _addressList[index].defaultStatus
                                ? Border.all(
                                    width: 2,
                                    color: Colors.blue,
                                  )
                                : Border.all(width: 0.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: RadioListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            value: _addressList[index].destinationId,
                            groupValue: _addressRadio,
                            onChanged: (value) {
                              setState(() {
                                _addressRadio = value!;
                              });
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _addressList[index].destinationName,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => _onClickUpdateButton(
                                          _addressList[index]),
                                      icon: const Icon(Icons.edit),
                                      iconSize: 36,
                                    ),
                                    IconButton(
                                      onPressed: () => _onClickDeleteButton(
                                          _addressList[index]),
                                      icon: const Icon(Icons.delete),
                                      iconSize: 36,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Text(
                              _addressList[index].destinationAddress,
                            ),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
