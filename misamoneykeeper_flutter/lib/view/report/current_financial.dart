import 'package:misamoneykeeper_flutter/common/exit_dialog.dart';
import 'package:misamoneykeeper_flutter/common/report_row.dart';
import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/current_financial_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/account/account_update.dart';

class CurrentFinancial extends StatefulWidget {
  const CurrentFinancial({super.key});

  @override
  State<CurrentFinancial> createState() => _CurrentFinancialState();
}

class _CurrentFinancialState extends State<CurrentFinancial> {
  final splashVM = Get.find<SplashViewModel>();
  late AccountViewModel accountViewModel;
  var sum = '0';
  int sumInt = 0;
  @override
  void initState() {
    super.initState();
    accountViewModel = Get.put(AccountViewModel());
  }

  // Future<void> _incrementCounter() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     sum = prefs.getString('sum') ?? '0';
  //     String chuoiMoi = sum.replaceAll(".", "");
  //     sumInt = int.parse(chuoiMoi);
  //   });
  // }
  @override
  void dispose() {
    Get.delete<CurrentFinancialViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AccountModel>?>(
      stream: accountViewModel.dataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loadingIndicator());
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.amber,
          );
        } else if (snapshot.hasData) {
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
              ReportRow(title: taichinhhientai, money: sum),
              10.heightBox,
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ReportRow(
                        title: "Sử dụng (${listData1.length} tài khoản)",
                        money: sum2),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listData1.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
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
                                  color: Colors.amber, shape: BoxShape.circle),
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
                                final RenderBox button = menuKey.currentContext!
                                    .findRenderObject() as RenderBox;
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
                    Container(
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    ReportRow(
                        title: "Sử dụng (${listData.length} tài khoản)",
                        money: sum1),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listData.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
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
                                  color: Colors.amber, shape: BoxShape.circle),
                              child: listData[index].acType == 1
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
                                final RenderBox button = menuKey.currentContext!
                                    .findRenderObject() as RenderBox;
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
                    )
                  ],
                ),
              ),
            ],
          ));
        } else {
          return Container(
            color: const Color.fromARGB(255, 63, 52, 18),
          );
        }
      },
    );
  }
}
