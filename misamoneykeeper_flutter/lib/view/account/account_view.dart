import 'package:misamoneykeeper_flutter/common/exit_dialog.dart';
import 'package:misamoneykeeper_flutter/common/report_row.dart';
import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/account/account_add.dart';
import 'package:misamoneykeeper_flutter/view/account/account_update.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late AccountViewModel accountViewModel;
  final splashVM = Get.find<SplashViewModel>();
  @override
  void initState() {
    super.initState();
    accountViewModel = Get.put(AccountViewModel());
  }

  @override
  void dispose() {
    Get.delete<AccountViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AccountAdd()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Tài sản',
          style: TextStyle(
            color: Colors.white,
            // Đặt màu chữ thành màu trắng
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              splashVM.logout();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<AccountModel>?>(
        stream: accountViewModel.dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingIndicator());
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.amber,
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(imgCoinBackGr),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Không có tài khoản nào!!',
                    style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                  ),
                ],
              )); // Hiển thị thông báo không có dữ liệu
            }
            var data = snapshot.data;
            int sum = 0;
            int sum1 = 0;
            int sum2 = 0;
            int type = 0;
            List<AccountModel> listData = [];
            List<AccountModel> listData1 = [];
            for (var element in data!) {
              sum += element.acMoney!;
              type = element.acType!;
              if (element.acType! == 3) {
                listData.add(element);
              }
              if (element.acType! == 1 || element.acType! == 2) {
                listData1.add(element);
              }
            }
            for (var item in listData) {
              sum1 += item.acMoney!;
            }
            for (var item in listData1) {
              sum2 += item.acMoney!;
            }
            return SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Tổng tài sản: ${formatCurrency(sum)}',
                    style: const TextStyle(
                        fontSize: 17,
                        fontFamily: sansBold,
                        color: Colors.black),
                  ),
                ),
                10.heightBox,
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ReportRow(
                          title: "Có (${listData1.length} tài sản lưu động)",
                          money: sum2),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listData1.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                            thickness: 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          var menuKey = GlobalKey();
                          return Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle),
                                child: listData1[index].acType == 1
                                    ? const Icon(
                                        Icons.account_balance_wallet,
                                        size: 25,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.account_balance,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                              ),
                              15.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ("${listData1[index].acName}")
                                      .text
                                      .size(16)
                                      .color(Colors.black)
                                      .fontFamily(sansBold)
                                      .make(),
                                  3.heightBox,
                                  formatCurrency(listData1[index].acMoney)
                                      .text
                                      .size(14)
                                      .fontFamily(sansBold)
                                      .color(Colors.black45)
                                      .make(),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                key: menuKey,
                                onPressed: () {
                                  final RenderBox overlay = Overlay.of(context)
                                      .context
                                      .findRenderObject() as RenderBox;
                                  final RenderBox button =
                                      menuKey.currentContext!.findRenderObject()
                                          as RenderBox;
                                  final position = button.localToGlobal(
                                      Offset.zero,
                                      ancestor: overlay);
                                  showMenu(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    position: RelativeRect.fromLTRB(position.dx,
                                        position.dy + button.size.height, 0, 0),
                                    items: [
                                      const PopupMenuItem(
                                        value: 1,
                                        child: Text("Sửa Tài Khoản",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: sansBold,
                                                color: Colors.black)),
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Text("Xóa Tài Khoản",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: sansBold,
                                                color: Colors.black)),
                                      ),
                                    ],
                                    elevation: 8,
                                  ).then((value) {
                                    if (value == 1) {
                                      Get.to(
                                          () => AccountUpdate(
                                              accountModel: listData1[index]),
                                          transition: Transition.rightToLeft);
                                    } else if (value == 2) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => ExitDialog(
                                                accountId:
                                                    listData1[index].accountId!,
                                              ));
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.more_vert,
                                  size: 25,
                                  color: Colors.black45,
                                ),
                              )
                            ],
                          )
                              .box
                              .padding(const EdgeInsets.symmetric(vertical: 5))
                              .margin(const EdgeInsets.symmetric(vertical: 5))
                              .make()
                              .onTap(() {});
                        },
                      ),
                      if (type == 3)
                        ReportRow(
                            title: "Có (${listData.length} tài sản cố định)",
                            money: sum1),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listData.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                            thickness: 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          var menuKey = GlobalKey();
                          return Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.two_wheeler,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              15.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ("${listData[index].acName}")
                                      .text
                                      .size(16)
                                      .color(Colors.black)
                                      .fontFamily(sansBold)
                                      .make(),
                                  3.heightBox,
                                  formatCurrency(listData[index].acMoney)
                                      .text
                                      .size(14)
                                      .fontFamily(sansBold)
                                      .color(Colors.black45)
                                      .make(),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                key: menuKey,
                                onPressed: () {
                                  final RenderBox overlay = Overlay.of(context)
                                      .context
                                      .findRenderObject() as RenderBox;
                                  final RenderBox button =
                                      menuKey.currentContext!.findRenderObject()
                                          as RenderBox;
                                  final position = button.localToGlobal(
                                      Offset.zero,
                                      ancestor: overlay);
                                  showMenu(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    position: RelativeRect.fromLTRB(position.dx,
                                        position.dy + button.size.height, 0, 0),
                                    items: [
                                      const PopupMenuItem(
                                        value: 1,
                                        child: Text("Sửa Tài Khoản",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: sansBold,
                                                color: Colors.black)),
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Text("Xóa Tài Khoản",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: sansBold,
                                                color: Colors.black)),
                                      ),
                                    ],
                                    elevation: 8,
                                  ).then((value) {
                                    if (value == 1) {
                                      Get.to(
                                          () => AccountUpdate(
                                              accountModel: listData[index]),
                                          transition: Transition.rightToLeft);
                                    } else if (value == 2) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => ExitDialog(
                                                accountId:
                                                    listData[index].accountId!,
                                              ));
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.more_vert,
                                  size: 25,
                                  color: Colors.black45,
                                ),
                              )
                            ],
                          )
                              .box
                              .padding(const EdgeInsets.symmetric(vertical: 5))
                              .margin(const EdgeInsets.symmetric(vertical: 5))
                              .make()
                              .onTap(() {});
                        },
                      ),
                    ],
                  ),
                )
              ],
            ));
          } else {
            return Container(
              color: const Color.fromARGB(255, 63, 52, 18),
            );
          }
        },
      ),
    );
  }
}
