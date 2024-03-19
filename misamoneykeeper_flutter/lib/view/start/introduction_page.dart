import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misamoneykeeper_flutter/view/auth/login_view.dart';
import 'package:misamoneykeeper_flutter/view/auth/signup.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  List<Map<String, String>> listData = [
    {
      "image": 'assets/images/image_1.png',
      "description":
          "Chào mừng đến với Sổ Thu Chi MISA. Trải nghiệm niềm vui quản lý tài chính bằng việc đăng ký trong lần đầu sử dụng"
    },
    {
      "image": 'assets/images/image_2.png',
      "description": "Kiểm soát thu chi, nhắm thẳng mục tiêu về tài chính"
    },
    {
      "image": 'assets/images/image_3.png',
      "description":
          "Hưởng thụ cuộc sống thoải mái, tự do tài chính với người thân, bạn bè"
    }
  ];

  Color? getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.grey;
    }
    return Colors.blue;
  }

  // String? email = '';
  // String url = "http://10.0.2.2:8000/api/misamoneykeeper/users/1";
  // void getUser() async {
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   var userData = json.decode(response.body);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(
  //       "name", userData['first_name'] + ' ' + userData['last_name']);
  //   prefs.setString("email", userData['email']);
  //   prefs.setInt("coin", userData['number_coins']);
  //   email = prefs.getString("name");
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Image.asset(
                              listData[index]['image']!,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                listData[index]['description']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const SignUpView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 63, 164, 247),
                          foregroundColor: Colors.white,
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        ).copyWith(
                            elevation: const MaterialStatePropertyAll(0)),
                        child: Text(
                          "Đăng ký tài khoản mới".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const LoginView());
                        },
                        style: ButtonStyle(
                          animationDuration: Duration.zero,
                          foregroundColor: MaterialStateProperty.resolveWith(
                            getColor,
                          ),
                          splashFactory: NoSplash.splashFactory,
                        ).copyWith(
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                        ),
                        child: Text(
                          'Đăng nhập'.toUpperCase(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.only(right: 5),
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            animationDuration: Duration.zero,
                            foregroundColor: MaterialStateProperty.resolveWith(
                              getColor,
                            ),
                            splashFactory: NoSplash.splashFactory,
                          ).copyWith(
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                          ),
                          child: const Text(
                            'Tiếng Việt',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
