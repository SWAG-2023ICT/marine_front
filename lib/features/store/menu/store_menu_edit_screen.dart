import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/models/database/price_model.dart';
import 'package:swag_marine_products/models/database/product_model.dart';
import 'package:swag_marine_products/providers/store_provider.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

enum OriginStatus {
  natural,
  aquaculture,
}

enum WeightUnit {
  g,
  kg,
  length,
}

enum EditType {
  add,
  update,
}

class PriceListModel {
  final String gram;
  final String price;

  PriceListModel({
    required this.gram,
    required this.price,
  });
}

class StoreMenuEditScreenArgs {
  const StoreMenuEditScreenArgs({
    required this.editType,
    this.productData,
  });

  final EditType editType;
  final ProductModel? productData;
}

class StoreMenuEditScreen extends StatefulWidget {
  static const routeName = "store_menu_edit";
  static const routeURL = "store_menu_edit";
  const StoreMenuEditScreen({
    super.key,
    required this.editType,
    this.productData,
  });

  final EditType editType;
  final ProductModel? productData;
  // final List<PriceListModel>? priceList;

  @override
  State<StoreMenuEditScreen> createState() => _StoreMenuEditScreenState();
}

class _StoreMenuEditScreenState extends State<StoreMenuEditScreen> {
  WeightUnit _weightUnit = WeightUnit.g;
  late OriginStatus _cultivationType;
  bool _isBarrier = false;
  bool _isSubmitted = false;
  bool _isPriceSubmitted = false;
  List<PriceModel>? _priceList;
  Uint8List? _productImage;

  @override
  void initState() {
    super.initState();

    _cultivationType = widget.productData != null
        ? widget.productData!.cultivationType == 1
            ? OriginStatus.natural
            : OriginStatus.aquaculture
        : OriginStatus.natural;

    _priceList = widget.productData != null ? widget.productData!.prices : [];

    _productNameController =
        TextEditingController(text: widget.productData?.productName);
    _productPriceController = TextEditingController();
    _productOriginController =
        TextEditingController(text: widget.productData?.origin);
    _productWeightUnitController = TextEditingController();
    _productDescriptionController =
        TextEditingController(text: widget.productData?.description);
    _productImage =
        widget.productData == null ? null : widget.productData!.productImage!;
  }

  void _onSubmit() async {
    if (widget.editType == EditType.add) {
      Dio dio = Dio();

      final formData = FormData.fromMap({
        "product": MultipartFile.fromString(
          jsonEncode(
            {
              "storeId": context.read<StoreProvider>().storeId,
              "origin": _productOriginController.text.trim(),
              "cultivationType":
                  _cultivationType == OriginStatus.natural ? 1 : 0,
              "productName": _productNameController.text.trim(),
              "productImage": null,
              "description": _productDescriptionController.text.trim(),
              "amount": 1,
              "prices": _priceList,
            },
          ),
          contentType: MediaType.parse('application/json'),
        ),
        "productImage": MultipartFile.fromBytes(
          _productImage!,
          filename: 'image.jpg',
        ),
      });
      dio.options.contentType = "multipart/form-data";
      final response = await dio.post(
        "${HttpIp.httpIp}/marine/product/addProduct",
        data: formData,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print("메뉴 등록 : 성공");
        context.pop();
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "통신 오류",
          message: response.data,
        );
      }
    } else if (widget.editType == EditType.update) {
      Dio dio = Dio();

      final formData = FormData.fromMap({
        "product": MultipartFile.fromString(
          jsonEncode(
            {
              "productId": widget.productData!.productId,
              "origin": _productOriginController.text.trim(),
              "cultivationType":
                  _cultivationType == OriginStatus.natural ? 1 : 0,
              "productName": _productNameController.text.trim(),
              "description": _productDescriptionController.text.trim(),
              "amount": 1,
              "prices": _priceList,
            },
          ),
          contentType: MediaType.parse('application/json'),
        ),
        "productImage": MultipartFile.fromBytes(
          _productImage!,
          filename: 'image.jpg',
        ),
      });
      dio.options.contentType = "multipart/form-data";
      final response = await dio.post(
        "${HttpIp.httpIp}/marine/product/updateProduct",
        data: formData,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print("메뉴 수정 : 성공");
        context.pop();
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "통신 오류",
          message: response.data,
        );
      }
    } else {
      swagPlatformDialog(
        context: context,
        title: "수정 오류!",
        message: "비정상적인 접근입니다!",
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

  void _onCheckSubmitted() {
    setState(() {
      _isSubmitted = (_productOriginController.text.trim().isNotEmpty &&
              _productOriginErrorText == null) &&
          (_productNameController.text.trim().isNotEmpty &&
              _productNameErrorText == null) &&
          (_productDescriptionController.text.trim().isNotEmpty &&
              _productDescriptionErrorText == null) &&
          (_priceList != null && _priceList!.isNotEmpty) &&
          _productImage != null;
    });
  }

  void _onCheckPriceSubmitted() {
    setState(() {
      _isPriceSubmitted =
          (_productWeightUnitController.text.trim().isNotEmpty &&
                  _productWeightUnitErrorText == null) &&
              (_productPriceController.text.trim().isNotEmpty &&
                  _productPriceErrorText == null);
    });
  }

  void _onFieldSubmitted(String value) {
    setState(() {
      _isBarrier = false;
    });
  }

  void onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  Future<void> _onChangeMenuImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      _productImage = await pickedFile.readAsBytes();
      setState(() {});
      _onCheckSubmitted();
    }
  }

  // ---------------- 원산지 ----------------

  late TextEditingController _productOriginController;
  String? _productOriginErrorText;

  void _validateProductOrigin(String value) {
    if (value.isEmpty) {
      setState(() {
        _productOriginErrorText = '원산지를 입력하세요.';
      });
    } else {
      setState(() {
        _productOriginErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  // ---------------- 상품 이름 ----------------

  late TextEditingController _productNameController;
  String? _productNameErrorText;

  void _validateProductName(String value) {
    if (value.isEmpty) {
      setState(() {
        _productNameErrorText = '제품명을 입력하세요.';
      });
    } else {
      setState(() {
        _productNameErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  // ---------------- 상품 설명 ----------------

  late TextEditingController _productDescriptionController;
  String? _productDescriptionErrorText;

  void _validateProductDescription(String value) {
    if (value.isEmpty) {
      setState(() {
        _productDescriptionErrorText = '제품설명을 입력하세요.';
      });
    } else {
      setState(() {
        _productDescriptionErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  // ---------------- 단위 ----------------

  late TextEditingController _productWeightUnitController;
  String? _productWeightUnitErrorText;

  void _validateProductWeightUnit(String value) {
    if (value.isEmpty) {
      setState(() {
        _productWeightUnitErrorText = '무게를 입력하세요.';
      });
    } else {
      setState(() {
        _productWeightUnitErrorText = null;
      });
      _onCheckPriceSubmitted();
    }
  }

  // ---------------- 가격 ----------------

  late TextEditingController _productPriceController;
  String? _productPriceErrorText;

  void _validatePriceDescription(String value) {
    if (value.isEmpty) {
      setState(() {
        _productPriceErrorText = '가격을 입력하세요.';
      });
    } else {
      setState(() {
        _productPriceErrorText = null;
      });
      _onCheckPriceSubmitted();
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productWeightUnitController.dispose();
    _productPriceController.dispose();
    _productOriginController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("메뉴 등록"),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: ElevatedButton(
          onPressed: _isSubmitted ? _onSubmit : null,
          child: const Text("등록"),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "이미지(1개)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                _onChangeMenuImage(ImageSource.camera),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              textStyle: const TextStyle(fontSize: 14),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text("카메라"),
                          ),
                          Gaps.h10,
                          ElevatedButton(
                            onPressed: () =>
                                _onChangeMenuImage(ImageSource.gallery),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              textStyle: const TextStyle(fontSize: 14),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text("갤러리"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_productImage == null)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: MediaQuery.of(context).size.width / 4,
                    ),
                  ),
                if (_productImage != null)
                  Image.memory(
                    _productImage!,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),
                Gaps.v6,
                const CenteredDivider(text: "입력"),
                Gaps.v6,
                Align(
                  alignment: Alignment.center,
                  child: SegmentedButton(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: OriginStatus.natural,
                        label: Text('자연산'),
                      ),
                      ButtonSegment(
                        value: OriginStatus.aquaculture,
                        label: Text('양식'),
                      ),
                    ],
                    selected: <OriginStatus>{_cultivationType},
                    onSelectionChanged: (Set<OriginStatus> newSelection) {
                      setState(() {
                        _cultivationType = newSelection.first;
                      });
                    },
                  ),
                ),
                Gaps.v6,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _productOriginController,
                        decoration: InputDecoration(
                          labelText: '원산지',
                          errorText: _productOriginErrorText,
                          prefixIcon: Icon(
                            Icons.badge_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: onChangeBarrier,
                        onChanged: _validateProductOrigin,
                        onFieldSubmitted: _onFieldSubmitted,
                      ),
                      Gaps.v8,
                      TextFormField(
                        controller: _productNameController,
                        decoration: InputDecoration(
                          labelText: '제품 이름',
                          errorText: _productNameErrorText,
                          prefixIcon: Icon(
                            Icons.badge_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: onChangeBarrier,
                        onChanged: _validateProductName,
                        onFieldSubmitted: _onFieldSubmitted,
                      ),
                      Gaps.v8,
                      TextFormField(
                        controller: _productDescriptionController,
                        decoration: InputDecoration(
                          labelText: '제품 설명',
                          errorText: _productDescriptionErrorText,
                          prefixIcon: Icon(
                            Icons.description_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: onChangeBarrier,
                        onChanged: _validateProductDescription,
                        onFieldSubmitted: _onFieldSubmitted,
                      ),
                    ],
                  ),
                ),
                Gaps.v10,
                const CenteredDivider(text: "그램별(g) 가격"),
                Gaps.v8,
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: _priceList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_priceList![index].unit),
                          const Text("-"),
                          // final formattedPrice = NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(price);
                          Text(
                              "${NumberFormat.currency(locale: 'ko_KR', symbol: '').format(_priceList![index].priceByUnit)}원"),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _priceList!.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Gaps.v8,
                Align(
                  alignment: Alignment.center,
                  child: SegmentedButton(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: WeightUnit.g,
                        label: Text('그램(g)'),
                      ),
                      ButtonSegment(
                        value: WeightUnit.kg,
                        label: Text('킬로그램(kg)'),
                      ),
                      ButtonSegment(
                        value: WeightUnit.length,
                        label: Text('마리(개수)'),
                      ),
                    ],
                    selected: <WeightUnit>{_weightUnit},
                    onSelectionChanged: (Set<WeightUnit> newSelection) {
                      setState(() {
                        _weightUnit = newSelection.first;
                      });
                    },
                  ),
                ),
                Gaps.v8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      // if (_weightUnit == WeightUnit.g)
                      TextFormField(
                        controller: _productWeightUnitController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: _weightUnit == WeightUnit.g
                              ? '그램(g)'
                              : _weightUnit == WeightUnit.kg
                                  ? '킬로그램(kg)'
                                  : "마리(개수)",
                          errorText: _productWeightUnitErrorText,
                          prefixIcon: Icon(
                            Icons.scale_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: onChangeBarrier,
                        onChanged: _validateProductWeightUnit,
                        onFieldSubmitted: _onFieldSubmitted,
                      ),
                      // if (_weightUnit == WeightUnit.kg)
                      //   TextFormField(
                      //     controller: _productWeightUnitController,
                      //     keyboardType: TextInputType.number,
                      //     decoration: InputDecoration(
                      //       labelText: '킬로그램(kg)',
                      //       errorText: _productWeightUnitErrorText,
                      //       prefixIcon: Icon(
                      //         Icons.scale_outlined,
                      //         color: Colors.grey.shade600,
                      //       ),
                      //     ),
                      //     onTap: onChangeBarrier,
                      //     onChanged: _validateProductWeightUnit,
                      //     onFieldSubmitted: _onFieldSubmitted,
                      //   ),
                      Gaps.v8,
                      TextFormField(
                        controller: _productPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '가격',
                          errorText: _productPriceErrorText,
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: onChangeBarrier,
                        onChanged: _validatePriceDescription,
                        onFieldSubmitted: _onFieldSubmitted,
                      ),
                    ],
                  ),
                ),
                Gaps.v8,
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                    ),
                    onPressed: _isPriceSubmitted
                        ? () {
                            setState(() {
                              _priceList!.add(
                                PriceModel(
                                  unit: _productWeightUnitController.text +
                                      (_weightUnit == WeightUnit.g
                                          ? "g"
                                          : _weightUnit == WeightUnit.kg
                                              ? "kg"
                                              : "마리"),
                                  priceByUnit:
                                      int.parse(_productPriceController.text),
                                ),
                              );
                              _productWeightUnitController.text = "";
                              _productPriceController.text = "";
                            });
                            _onCheckSubmitted();
                          }
                        : null,
                    child: const Text("추가"),
                  ),
                ),
              ],
            ),
          ),
          if (_isBarrier)
            ModalBarrier(
              // color: _barrierAnimation,
              color: Colors.transparent,
              // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
              dismissible: true,
              // 자신을 클릭하면 실행되는 함수
              onDismiss: () {
                setState(() {
                  _isBarrier = false;
                  FocusScope.of(context).unfocus();
                });
              },
            ),
        ],
      ),
    );
  }
}
