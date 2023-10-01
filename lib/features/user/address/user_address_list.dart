import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/features/user/address/user_address_edit.dart';
import 'package:swag_marine_products/storages/address_storage.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class UserAddressList extends StatefulWidget {
  const UserAddressList({Key? key}) : super(key: key);

  @override
  State<UserAddressList> createState() => _UserAddressListState();
}

class _UserAddressListState extends State<UserAddressList> {
  String _address = "우리집";
  bool _isFirstLoading = false;

  List<Map<String, String>> _addressList = [];

  @override
  void initState() {
    super.initState();

    _initAddressList();
  }

  void _initAddressList() async {
    setState(() {
      _isFirstLoading = true;
    });

    _addressList = await AddressStorage.getAddressList();

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

  void _onClickApplyButton() async {
    final addressList = await AddressStorage.getAddressList();
    print(addressList);
  }

  void _onClickUpdateButton(Map<String, String> data) async {
    final address = data.values.first.split(",");

    if (address.length == 2) {
      await showModalBottomSheet(
        context: context,
        builder: (context) => UserAddressEdit(
          editType: AddressEditType.update,
          addressKey: data.keys.first,
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
          addressKey: data.keys.first,
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

  void _onClickDeleteButton(String key) async {
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
    } else {
      await AddressStorage.removeAddressList(key);

      _initAddressList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CenteredDivider(text: "주소 리스트"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
        ),
        _isFirstLoading
            ? const CircularProgressIndicator.adaptive()
            : RefreshIndicator.adaptive(
                onRefresh: () async => _initAddressList(),
                child: ListView.separated(
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
                        border: Border.all(width: 0.5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: RadioListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        value: _addressList[index].keys.first,
                        groupValue: _address,
                        onChanged: (value) {
                          setState(() {
                            _address = value!;
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
                                _addressList[index].keys.first,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _onClickUpdateButton(_addressList[index]),
                                  icon: const Icon(Icons.edit),
                                  iconSize: 36,
                                ),
                                IconButton(
                                  onPressed: () => _onClickDeleteButton(
                                      _addressList[index].keys.first),
                                  icon: const Icon(Icons.delete),
                                  iconSize: 36,
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Text(
                          _addressList[index].values.first,
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
