import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/features/store/navigation/menus/widgets/store_user_profile_card.dart';
import 'package:swag_marine_products/features/store/order/store_order_check_screen.dart';
import 'package:swag_marine_products/features/store/profile/store_inform_screen.dart';
import 'package:swag_marine_products/features/store/profile/store_inform_update_screen.dart';
import 'package:swag_marine_products/features/user/navigation/menus/widgets/profile_button.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_screen.dart';
import 'package:swag_marine_products/models/database/store_model.dart';

class StoreProfileScreen extends StatefulWidget {
  const StoreProfileScreen({
    super.key,
    required this.storeData,
  });

  final StoreModel storeData;

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  XFile? _productImage;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        title: const Text("프로필"),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(StoreInformScreen.routeName);
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const StoreUserProfileCard(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileButton(
                    onPressed: () {
                      context.pushNamed(StoreOrderCheckScreen.routeName);
                    },
                    icon: Icons.playlist_play_rounded,
                    text: "판매 내역",
                    color: Colors.grey,
                  ),
                  // ProfileButton(
                  //   icon: Icons.data_exploration_outlined,
                  //   text: "판매 통계",
                  //   color: Colors.grey,
                  // ),
                ],
              ),
            ),
            const CenteredDivider(text: "가게 정보 관리"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.storeData.storeName,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "가게 이름",
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     context.pushNamed(
                      //       StoreInformUpdateScreen.routeName,
                      //       extra: const StoreInformUpdateScreenArgs(
                      //         updateType: UpdateType.storeName,
                      //       ),
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     padding: const EdgeInsets.all(24),
                      //     textStyle: const TextStyle(fontSize: 14),
                      //     shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      //   child: const Text("수정"),
                      // ),
                    ],
                  ),
                  Gaps.v10,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.storeData.storeAddress,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "가게 주소",
                            prefixIcon: Icon(
                              Icons.badge_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     context.pushNamed(
                      //       StoreInformUpdateScreen.routeName,
                      //       extra: const StoreInformUpdateScreenArgs(
                      //         updateType: UpdateType.storeAddress,
                      //       ),
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     padding: const EdgeInsets.all(24),
                      //     textStyle: const TextStyle(fontSize: 14),
                      //     shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      //   child: const Text("수정"),
                      // ),
                    ],
                  ),
                  Gaps.v10,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.storeData.storePhoneNumber,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "가게 전화번호",
                            prefixIcon: Icon(
                              Icons.phone_iphone_rounded,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     context.pushNamed(
                      //       StoreInformUpdateScreen.routeName,
                      //       extra: const StoreInformUpdateScreenArgs(
                      //         updateType: UpdateType.storePhoneNumber,
                      //       ),
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     padding: const EdgeInsets.all(24),
                      //     textStyle: const TextStyle(fontSize: 14),
                      //     shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      //   child: const Text("수정"),
                      // ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "이미지",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // Row(
                        //   children: [
                        //     ElevatedButton(
                        //       onPressed: () =>
                        //           _onChangeMenuImage(ImageSource.camera),
                        //       style: ElevatedButton.styleFrom(
                        //         padding: const EdgeInsets.all(10),
                        //         textStyle: const TextStyle(fontSize: 14),
                        //         shape: const RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.all(
                        //             Radius.circular(10),
                        //           ),
                        //         ),
                        //       ),
                        //       child: const Text("카메라"),
                        //     ),
                        //     Gaps.h10,
                        //     ElevatedButton(
                        //       onPressed: () =>
                        //           _onChangeMenuImage(ImageSource.gallery),
                        //       style: ElevatedButton.styleFrom(
                        //         padding: const EdgeInsets.all(10),
                        //         textStyle: const TextStyle(fontSize: 14),
                        //         shape: const RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.all(
                        //             Radius.circular(10),
                        //           ),
                        //         ),
                        //       ),
                        //       child: const Text("갤러리"),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Image.memory(
                    widget.storeData.storeImage!,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
