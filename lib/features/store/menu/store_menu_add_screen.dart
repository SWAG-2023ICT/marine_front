import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class PriceModel {
  final String gram;
  final String price;

  PriceModel({
    required this.gram,
    required this.price,
  });
}

class StoreMenuAddScreen extends StatefulWidget {
  static const routeName = "store_menu_add";
  static const routeURL = "store_menu_add";
  const StoreMenuAddScreen({super.key});

  @override
  State<StoreMenuAddScreen> createState() => _StoreMenuAddScreenState();
}

class _StoreMenuAddScreenState extends State<StoreMenuAddScreen> {
  String _origin = "국내산";
  bool _isBarrier = false;
  bool _isSubmitted = false;
  bool _isPriceSubmitted = false;
  final List<PriceModel> _priceList = [];
  XFile? _productImage;

  void _onCheckSubmitted() {
    setState(() {
      _isSubmitted = (_productNameController.text.trim().isNotEmpty &&
              _productNameErrorText == null) &&
          (_productDescriptionController.text.trim().isNotEmpty &&
              _productDescriptionErrorText == null) &&
          (_productImage != null);
    });
  }

  void _onCheckPriceSubmitted() {
    setState(() {
      _isPriceSubmitted = (_productGramController.text.trim().isNotEmpty &&
              _productGramErrorText == null) &&
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

  void _onChangeOrigin(String? value) {
    if (value == null) return;
    setState(() {
      _origin = value;
    });
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

  final TextEditingController _productGramController = TextEditingController();
  String? _productGramErrorText;

  void _validateProductGram(String value) {
    if (value.isEmpty) {
      setState(() {
        _productGramErrorText = '그램(g)을 입력하세요.';
      });
    } else {
      setState(() {
        _productGramErrorText = null;
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
    _productGramController.dispose();
    _productPriceController.dispose();

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
          onPressed: _isSubmitted
              ? () {
                  print("제품 원산지 : $_origin");
                  print("제품 이름 : ${_productNameController.text}");
                  print("제품 설명 : ${_productDescriptionController.text}");
                  print("제품 가격 : ${_priceList.toString()}");
                  print("제품 사진 : $_productImage");
                }
              : null,
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
                      Row(
                        children: [
                          const Text(
                            "원산지 :",
                            style: TextStyle(fontSize: 18),
                          ),
                          Gaps.h6,
                          DropdownButton(
                            value: _origin,
                            items: const [
                              DropdownMenuItem(
                                value: "국내산",
                                child: Text("국내산"),
                              ),
                              DropdownMenuItem(
                                value: "외국산",
                                child: Text("외국산"),
                              ),
                            ],
                            onChanged: _onChangeOrigin,
                          ),
                        ],
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
                  itemCount: _priceList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${_priceList[index].gram}g"),
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _productGramController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '그램(g)',
                          errorText: _productGramErrorText,
                          prefixIcon: Icon(
                            Icons.scale_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: onChangeBarrier,
                        onChanged: _validateProductGram,
                        onFieldSubmitted: _onFieldSubmitted,
                      ),
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
                            if (_priceList.any((item) =>
                                item.gram == _productGramController.text)) {
                              swagPlatformDialog(
                                context: context,
                                title: "가격 오류",
                                message: "동일한 그램(g)이 존재합니다!",
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text("알겠습니다"),
                                  ),
                                ],
                              );
                              return;
                            } else {
                              setState(() {
                                _priceList.add(
                                  PriceModel(
                                    gram: _productGramController.text,
                                    price: _productPriceController.text,
                                  ),
                                );
                                _productGramController.text = "";
                                _productPriceController.text = "";
                              });
                              _onCheckSubmitted();
                            }
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
