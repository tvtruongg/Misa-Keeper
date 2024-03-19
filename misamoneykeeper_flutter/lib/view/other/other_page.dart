import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:misamoneykeeper_flutter/common/buttom_widget.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/Colors.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/add/category_view.dart';
import 'package:misamoneykeeper_flutter/view/info/information_view.dart';
import 'package:misamoneykeeper_flutter/view/other/notification_view.dart';
import 'package:misamoneykeeper_flutter/view/report/report_details.dart';
import 'package:misamoneykeeper_flutter/view/setting/setting_view.dart';
import 'package:misamoneykeeper_flutter/view/split_money/split_money_view.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  final splashVM = Get.find<SplashViewModel>();
  @override
  void initState() {
    super.initState();
  }

  Future processBar() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatData =
        formatDate(now, [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InformationView()),
                    );
                  },
                  style: TextButton.styleFrom(
                          animationDuration: Duration.zero,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10))
                      .copyWith(
                    overlayColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(5), // Border radius
                          child: ClipOval(
                            child: Image.asset(imgSaveMoney),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${splashVM.userModel.value.firstName} '
                            '${splashVM.userModel.value.lastName}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${splashVM.userModel.value.email}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationView()));
                        },
                        icon: const Icon(Icons.notifications,
                            size: 28, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              // Container(
              //   color: Colors.white,
              //   child: Column(
              //     children: [
              //       // Stack(
              //       //   alignment: Alignment.center,
              //       //   children: [
              //       //     Image.asset('assets/images/rocket.png'),
              //       //     ElevatedButton(
              //       //       onPressed: () {},
              //       //       style: ElevatedButton.styleFrom(
              //       //         backgroundColor: Colors.white,
              //       //         foregroundColor: Colors.orange[600],
              //       //         splashFactory: NoSplash.splashFactory,
              //       //         elevation: 0,
              //       //         shadowColor: Colors.transparent,
              //       //         shape: RoundedRectangleBorder(
              //       //           borderRadius: BorderRadius.circular(32),
              //       //         ),
              //       //         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              //       //       ).copyWith(
              //       //           elevation: const MaterialStatePropertyAll(0)),
              //       //       child: const Text(
              //       //         'Nâng cấp Premium',
              //       //         style: TextStyle(
              //       //             fontWeight: FontWeight.bold, fontSize: 16),
              //       //       ),
              //       //     ),
              //       //   ],
              //       // ),
              //       Container(
              //         padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              //         child: Row(
              //           children: [
              //             buttonBorderWidget(
              //                 image: imgCoin,
              //                 title: 'Xu của bạn',
              //                 content: '4000 xu'),
              //             const SizedBox(width: 10),
              //             buttonBorderWidget(
              //                 image: imgBack,
              //                 title: 'Chia sẻ nhận xu',
              //                 content: 'Mã 380 1596'),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        'Tính năng',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: GridView(
                        primary: false,
                        padding: const EdgeInsets.all(3),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 4,
                        ),
                        children: [
                          ButtomWidget(
                            color: RED,
                            image: imgInvoice,
                            scaleImage: 1.0,
                            text: tinhhinhthuchi,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ReportDetails(
                                            idx: 1,
                                          )));
                            },
                          ),
                          ButtomWidget(
                            color: BLUE,
                            image: imgList,
                            scaleImage: 0.9,
                            text: CATAGORY,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryView()));
                            },
                          ),
                          ButtomWidget(
                            color: AQUA,
                            image: imgShopping,
                            scaleImage: 1.3,
                            text: phantichchitieu,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ReportDetails(
                                            idx: 2,
                                          )));
                            },
                          ),
                          ButtomWidget(
                            color: ORANGE,
                            image: imgCalendar,
                            scaleImage: 0.8,
                            text: phantichthu,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ReportDetails(
                                            idx: 3,
                                          )));
                            },
                          ),
                          // ButtomWidget(
                          //   color: PURPLE,
                          //   image: imgWriting,
                          //   scaleImage: 1.0,
                          //   text: RECORD_SAMPLE,
                          //   onPressed: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 const SampleNotesView()));
                          //   },
                          // ),
                          // ButtomWidget(
                          //   color: YELLOW,
                          //   image: imgTransfer,
                          //   scaleImage: 0.9,
                          //   text: EXPECTED,
                          //   onPressed: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 const ExpectedView()));
                          //   },
                          // ),
                          // ButtomWidget(
                          //   color: LIGHT_BLUE,
                          //   image: imgExport,
                          //   scaleImage: 1,
                          //   text: EXPORT_DATA,
                          //   onPressed: () {
                          //     // Navigator.push(
                          //     //     context,
                          //     //     MaterialPageRoute(
                          //     //         builder: (context) =>
                          //     //             const ExportData()));
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        'Tiện ích',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    GridView(
                      primary: false,
                      padding: const EdgeInsets.all(5),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 4,
                      ),
                      children: [
                        // ButtomWidget(
                        //   color: GREEN,
                        //   image: imgPig,
                        //   scaleImage: 0.9,
                        //   text: SAVINGS,
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => const SavingView()));
                        //   },
                        // ),
                        ButtomWidget(
                          color: LIGHT_BLUE,
                          image: imgMoneyBag,
                          scaleImage: 0.8,
                          text: SPLIT_MONEY,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SplitMoneyView()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingView()),
                        );
                      },
                      style: TextButton.styleFrom(
                        animationDuration: Duration.zero,
                        splashFactory: NoSplash.splashFactory,
                      ).copyWith(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(PURPLE),
                                child: Padding(
                                  padding: EdgeInsets.all(5), // Border radius
                                  child: ClipOval(
                                      child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                                ),
                              ),
                              SizedBox(width: 15),
                              Text(
                                SETTINGS,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 0.4,
                            height: 0.1,
                            indent: 10,
                            endIndent: 10,
                          )
                        ],
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const HelpInfoView()),
                    //     );
                    //   },
                    //   style: TextButton.styleFrom(
                    //     animationDuration: Duration.zero,
                    //     splashFactory: NoSplash.splashFactory,
                    //   ).copyWith(
                    //     overlayColor:
                    //         const MaterialStatePropertyAll(Colors.transparent),
                    //   ),
                    //   child: const Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           CircleAvatar(
                    //             radius: 20,
                    //             backgroundColor: Color(GREY),
                    //             child: Padding(
                    //               padding: EdgeInsets.all(5), // Border radius
                    //               child: ClipOval(
                    //                   child: Icon(
                    //                 Icons.info_outline,
                    //                 color: Colors.white,
                    //                 size: 20,
                    //               )),
                    //             ),
                    //           ),
                    //           SizedBox(width: 15),
                    //           Text(
                    //             HELP_INFORMATION,
                    //             style: TextStyle(
                    //                 fontSize: 16, color: Colors.black),
                    //           ),
                    //           Spacer(),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Divider(
                    //         thickness: 0.4,
                    //         height: 0.1,
                    //         indent: 10,
                    //         endIndent: 10,
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  const CircularProgressIndicator();
                  setState(() {
                    // processBar();
                    final now = DateTime.now();
                    // ignore: unused_local_variable
                    var formatData = formatDate(now,
                        [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]);
                  });
                },
                style: TextButton.styleFrom(
                  animationDuration: Duration.zero,
                  splashFactory: NoSplash.splashFactory,
                ).copyWith(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sync),
                    Text(
                      'Đồng bộ dữ liệu',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Động bộ lần cuối lúc $formatData',
                style: const TextStyle(
                  color: Color(GREY),
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
