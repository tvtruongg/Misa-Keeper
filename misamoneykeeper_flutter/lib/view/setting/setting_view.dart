import 'package:misamoneykeeper_flutter/utility/Colors.dart';
import 'package:misamoneykeeper_flutter/utility/common_widgets.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool _on = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          SETTINGS,
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Colors.grey[200],
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'HIỂN THỊ',
                      style: TextStyle(color: Color(GREY)),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: buttonMenu(
                              text: LANGUAGE_TYPE, text2: LANGUAGE, func: null),
                        ),
                        buttonMenu(
                            text: TIME_FORMAT_TYPE,
                            text2: TIME_FORMAT,
                            func: null),
                        buttonMenu(
                            text: DEFAULT_SCREEN, text2: OVERVIEW, func: null),
                        buttonMenu(
                            text: SHOW_DETAILS,
                            text2: ALWAYS_CLOSE,
                            func: null),
                        buttonMenu(
                            text: SET_CURRENCY,
                            text2: VND_CURRENCY,
                            func: null),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'BẢO MẬT',
                      style: TextStyle(color: Color(GREY)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Mã bảo vệ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: SwitchListTile(
                                activeColor: Colors.blueAccent,
                                value: _on,
                                onChanged: (value) =>
                                    setState(() => _on = value),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 0.3,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'BÁO CÁO',
                      style: TextStyle(color: Color(GREY)),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: buttonMenu(
                              text: 'Ngày bắt đầu của tuần',
                              text2: 'Thứ 2',
                              func: null),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            animationDuration: Duration.zero,
                            splashFactory: NoSplash.splashFactory,
                          ).copyWith(
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                          ),
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ngày bắt đầu của tháng',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Tháng này 01/02/2024 - 29/02/2024',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.grey,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                height: 0.3,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            animationDuration: Duration.zero,
                            splashFactory: NoSplash.splashFactory,
                          ).copyWith(
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                          ),
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tháng bắt đầu của năm',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Năm này 01/01/2024 - 31/12/2024',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        'Tháng 1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.grey,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                height: 0.3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
