import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

enum WeightUnit {
  g,
  kg,
  length,
}

enum EditType {
  add,
  update,
}

class PriceModel {
  final String gram;
  final String price;

  PriceModel({
    required this.gram,
    required this.price,
  });
}

class StoreMenuEditScreenArgs {
  const StoreMenuEditScreenArgs({
    required this.editType,
  });

  final EditType editType;
}

class StoreMenuEditScreen extends StatefulWidget {
  static const routeName = "store_menu_edit";
  static const routeURL = "store_menu_edit";
  const StoreMenuEditScreen({
    super.key,
    required this.editType,
  });

  final EditType editType;

  @override
  State<StoreMenuEditScreen> createState() => _StoreMenuEditScreenState();
}

class _StoreMenuEditScreenState extends State<StoreMenuEditScreen> {
  WeightUnit _weightUnit = WeightUnit.g;
  bool _isBarrier = false;
  bool _isSubmitted = false;
  bool _isPriceSubmitted = false;
  final List<PriceModel> _priceList = [];
  XFile? _productImage;

  void _onSubmit() async {
    print("제품 원산지 : $_productOriginController.text");
    print("제품 이름 : ${_productNameController.text}");
    print("제품 설명 : ${_productDescriptionController.text}");
    print("제품 가격 : ${_priceList.toString()}");
    print("제품 사진 : $_productImage");

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

  void _onCheckSubmitted() {
    setState(() {
      _isSubmitted = (_productOriginController.text.trim().isNotEmpty &&
              _productOriginErrorText == null) &&
          (_productNameController.text.trim().isNotEmpty &&
              _productNameErrorText == null) &&
          (_productDescriptionController.text.trim().isNotEmpty &&
              _productDescriptionErrorText == null) &&
          (_productImage != null);
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
      setState(() {
        _productImage = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  void _onChangeOrigin(WeightUnit? value) {
    if (value == null) return;
    setState(() {
      _weightUnit = value;
    });
  }

  // ---------------- 원산지 ----------------

  final TextEditingController _productOriginController =
      TextEditingController();
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

  final TextEditingController _productNameController = TextEditingController();
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

  final TextEditingController _productDescriptionController =
      TextEditingController();
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

  // ---------------- 그램(g) ----------------

  final TextEditingController _productWeightUnitController =
      TextEditingController();
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

  final TextEditingController _productPriceController = TextEditingController();
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
    print(_priceList.toString());
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
                if (_productImage != null)
                  Image.file(
                    File(_productImage!.path),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),
                if (_productImage == null)
                  Image.asset(
                    "assets/images/fishShop.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),
                Gaps.v6,
                const CenteredDivider(text: "입력"),
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
                // Row(
                //   children: [
                //     const Text(
                //       "무게 단위 :",
                //       style: TextStyle(fontSize: 18),
                //     ),
                //     Gaps.h6,
                //     DropdownButton(
                //       value: _weightUnit,
                //       items: const [
                //         DropdownMenuItem(
                //           value: WeightUnit.g,
                //           child: Text("그램(g)"),
                //         ),
                //         DropdownMenuItem(
                //           value: WeightUnit.kg,
                //           child: Text("킬로그램(kg)"),
                //         ),
                //       ],
                //       onChanged: _onChangeOrigin,
                //     ),
                //   ],
                // ),
                Gaps.v8,
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: _priceList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_priceList[index].gram),
                          const Text("-"),
                          Text("${_priceList[index].price}원"),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _priceList.removeAt(index);
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          _weightUnit = WeightUnit.g;
                        }),
                        child: Container(
                          child: Row(
                            children: [
                              Radio.adaptive(
                                value: WeightUnit.g,
                                groupValue: _weightUnit,
                                onChanged: (value) => setState(() {
                                  if (value != null) {
                                    _weightUnit = value;
                                  }
                                }),
                              ),
                              const Text("그램(g)"),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          _weightUnit = WeightUnit.kg;
                        }),
                        child: Container(
                          child: Row(
                            children: [
                              Radio.adaptive(
                                value: WeightUnit.kg,
                                groupValue: _weightUnit,
                                onChanged: (value) => setState(() {
                                  if (value != null) {
                                    _weightUnit = value;
                                  }
                                }),
                              ),
                              const Text("킬로그램(kg)"),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          _weightUnit = WeightUnit.length;
                        }),
                        child: Container(
                          child: Row(
                            children: [
                              Radio.adaptive(
                                value: WeightUnit.length,
                                groupValue: _weightUnit,
                                onChanged: (value) => setState(() {
                                  if (value != null) {
                                    _weightUnit = value;
                                  }
                                }),
                              ),
                              const Text("마리(개수)"),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                              _priceList.add(
                                PriceModel(
                                  gram: _productWeightUnitController.text +
                                      (_weightUnit == WeightUnit.g
                                          ? "g"
                                          : _weightUnit == WeightUnit.kg
                                              ? "kg"
                                              : "마리"),
                                  price: _productPriceController.text,
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
