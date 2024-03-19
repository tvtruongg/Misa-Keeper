import 'package:flutter/services.dart';
import 'package:misamoneykeeper_flutter/controller/account_add_view_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountAdd extends StatefulWidget {
  const AccountAdd({super.key});

  @override
  State<AccountAdd> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AccountAdd> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _accountTypes = [
    'Tiền mặt',
    'Ngân hàng',
    'Tài sản cố định'
  ];
  var accountAddVM = Get.put(AccountAddViewModel());
  @override
  void initState() {
    super.initState();
    accountAddVM.clean();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thêm tài sản',
            style: TextStyle(
              color: Colors.white,
              // Đặt màu chữ thành màu trắng
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.close, // Icon dấu X
              color: Colors.white, // Đặt màu của icon thành màu trắng
            ),
            onPressed: () {
              Navigator.pop(context); // Đóng trang khi nhấn nút dấu X
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => accountAddVM.isLoading.value == true
                ? Center(child: loadingIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Card(
                            child: TextFormField(
                              controller: accountAddVM.balanceController.value,
                              keyboardType:
                                  TextInputType.number, // Chỉ cho phép nhập số
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .digitsOnly // Chỉ cho phép số
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập giá trị tài sản';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                labelText: 'Giá trị tài sản',
                                prefixIcon: Icon(Icons.attach_money),
                              ),
                            ),
                          ),
                          Card(
                            child: TextFormField(
                              controller: accountAddVM.nameController.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập tên';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                labelText: 'Tên',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          Obx(
                            () => DropdownButton(
                              value: accountAddVM.accountType.value,
                              isExpanded: true,
                              underline: const SizedBox(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              items: _accountTypes.map((accountType) {
                                return DropdownMenuItem(
                                  value: accountType,
                                  child: Row(
                                    children: [
                                      if (accountType == 'Tiền mặt')
                                        const Icon(Icons.account_balance_wallet)
                                      else if (accountType == 'Ngân hàng')
                                        const Icon(Icons.account_balance)
                                      else if (accountType == 'Tài sản cố định')
                                        const Icon(Icons.two_wheeler),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(accountType),
                                    ],
                                  ),
                                );
                              }).toList(),
                              // Xóa đối số vị trí thừa
                              onChanged: (newValue) {
                                accountAddVM.accountType.value =
                                    newValue ?? 'Tiền mặt';
                                if (newValue == 'Tiền mặt') {
                                  accountAddVM.accountTypeId.value = 1;
                                } else if (newValue == 'Ngân hàng') {
                                  accountAddVM.accountTypeId.value = 2;
                                } else {
                                  accountAddVM.accountTypeId.value = 3;
                                }
                              },
                            ),
                          ),
                          Card(
                            child: TextFormField(
                              controller:
                                  accountAddVM.descriptionController.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập diễn giải';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                labelText: 'Diễn giải',
                                prefixIcon: Icon(Icons.sort),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue, // Màu xanh
                                  minimumSize: const Size(
                                      200.0, 50.0), // Chiều dài và chiều cao
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    accountAddVM.serviceCallCategory();
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                    Text('Lưu',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
