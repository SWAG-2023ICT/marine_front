import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/models/database/destination_model.dart';
import 'package:swag_marine_products/providers/user_provider.dart';
import 'package:swag_marine_products/storages/address_storage.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

enum AddressEditType {
  add,
  update,
}

class UserAddressEdit extends StatefulWidget {
  const UserAddressEdit({
    super.key,
    required this.editType,
    this.addressId,
    this.addressKey,
    this.addressValue,
    this.addressDetail,
  });

  final AddressEditType editType;
  final int? addressId;
  final String? addressKey;
  final String? addressValue;
  final String? addressDetail;

  @override
  State<UserAddressEdit> createState() => _UserAddressEditState();
}

class _UserAddressEditState extends State<UserAddressEdit> {
  late TextEditingController _userAdressNameController;
  late TextEditingController _userAddressController;
  late TextEditingController _userAddressDetailController;

  String? _userAdressNameErrorText;
  String? _zipCode;

  bool _isStubmitted = false;

  @override
  void initState() {
    super.initState();

    _userAdressNameController = TextEditingController(text: widget.addressKey);
    _userAddressController = TextEditingController(text: widget.addressValue);
    _userAddressDetailController =
        TextEditingController(text: widget.addressDetail);
  }

  void _onCheckSubmitted() {
    setState(() {
      _isStubmitted = (_userAdressNameErrorText == null &&
              _userAdressNameController.text.trim().isNotEmpty) &&
          (_userAddressController.text.trim().isNotEmpty);
    });
  }

  void _onClickSubmitted() async {
    if (widget.editType == AddressEditType.add) {
      final url =
          Uri.parse("${HttpIp.httpIp}/marine/destination/addDestination");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "userId": context.read<UserProvider>().userData!.userId,
        "destinationName": _userAdressNameController.text.trim().isEmpty
            ? _userAddressDetailController.text.trim().isNotEmpty
                ? "${_userAddressController.text.trim()},${_userAddressDetailController.text.trim()}"
                : _userAddressController.text.trim()
            : _userAdressNameController.text.trim(),
        "destinationAddress": _userAddressDetailController.text
                .trim()
                .isNotEmpty
            ? "${_userAddressController.text.trim()},${_userAddressDetailController.text.trim()}"
            : _userAddressController.text.trim(),
        "zipCode": _zipCode,
      };
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("유저 주소 추가 : 성공");
        context.pop();
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "통신 오류",
          message: response.body,
        );
      }
    } else if (widget.editType == AddressEditType.update) {
      final url =
          Uri.parse("${HttpIp.httpIp}/marine/destination/updateDestination");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "userId": context.read<UserProvider>().userData!.userId,
        "destinationId": widget.addressId,
        "destinationName": _userAdressNameController.text.trim().isEmpty
            ? _userAddressDetailController.text.trim().isNotEmpty
                ? "${_userAddressController.text.trim()},${_userAddressDetailController.text.trim()}"
                : _userAddressController.text.trim()
            : _userAdressNameController.text.trim(),
        "destinationAddress": _userAddressDetailController.text
                .trim()
                .isNotEmpty
            ? "${_userAddressController.text.trim()},${_userAddressDetailController.text.trim()}"
            : _userAddressController.text.trim(),
        "zipCode": _zipCode,
      };
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("유저 주소 수정 : 성공");
        context.pop();
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "통신 오류",
          message: response.body,
        );
      }
    } else {
      swagPlatformDialog(
        context: context,
        title: "접근 오류!",
        message: "지정되지 않은 접근입니다!",
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              context.pop();
            },
            child: const Text("알겠습니다"),
          ),
        ],
      );
    }
  }

  void _onSearchUserAddress() async {
    Kpostal? result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => KpostalView()));
    if (result != null) {
      setState(() {
        _userAddressController.text = result.address;
        _zipCode = result.postCode;
      });
      _onCheckSubmitted();
    }
  }

  void _validateUserAdressName(String value) {
    if (value.isEmpty) {
      setState(() {
        _userAdressNameErrorText = '주소의 별명을 입력해주세요!';
      });
    } else {
      setState(() {
        _userAdressNameErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  void _validateUserAddressDetail(String value) {
    _onCheckSubmitted();
  }

  @override
  void dispose() {
    _userAddressController.dispose();
    _userAdressNameController.dispose();
    _userAddressDetailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:
              Text(widget.editType == AddressEditType.add ? "주소 추가" : "주소 수정"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextFormField(
                controller: _userAdressNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '별명',
                  errorText: _userAdressNameErrorText,
                  // prefixIcon: Icon(
                  //   Icons.tag,
                  //   color: Colors.grey.shade600,
                  // ),
                ),
                onChanged: _validateUserAdressName,
              ),
              Gaps.v10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _userAddressController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: '주소',
                        prefixIcon: Icon(
                          Icons.home_work_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _onSearchUserAddress,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("주소 검색"),
                  ),
                ],
              ),
              Gaps.v10,
              TextFormField(
                controller: _userAddressDetailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '주소 상세 정보',
                  prefixIcon: Icon(
                    Icons.add_home_work_outlined,
                    color: Colors.grey.shade600,
                  ),
                ),
                onChanged: _validateUserAddressDetail,
              ),
              ElevatedButton(
                onPressed: _isStubmitted ? _onClickSubmitted : null,
                child: Text(
                  widget.editType == AddressEditType.add ? "추가" : "수정",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
