import 'package:misamoneykeeper_flutter/common/validator.dart';
import 'package:misamoneykeeper_flutter/view/auth/signup.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/controller/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authVM = Get.put(LoginViewModel());
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20), // Đặt bán kính bo góc ở đây
                  child: Image.asset(
                    icLogo,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                10.heightBox,
                const Text(
                  'Sổ Thu Chi MISA',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: authVM.txtEmail.value,
                        validator: EmailValidator.validate,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: authVM.txtPassword.value,
                        obscureText: !authVM.isShowPasswordLogin.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          suffixIcon: IconButton(
                            onPressed: () {
                              authVM.showPassword();
                              setState(() {});
                            },
                            icon: Icon(!authVM.isShowPasswordLogin.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Button Login
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  authVM.serviceCallLogin();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ).copyWith(
                                elevation: const MaterialStatePropertyAll(0),
                              ),
                              child: Text(
                                'Đăng nhập'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text(
                          //   'Quên mật khẩu'.toUpperCase(),
                          //   style: const TextStyle(
                          //       color: Colors.blue, fontSize: 13),
                          // ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => const SignUpView());
                              },
                              child: "Đăng ký"
                                  .text
                                  .size(16)
                                  .fontFamily(sansBold)
                                  .color(Colors.blue)
                                  .make())
                        ],
                      ),
                      // const SizedBox(height: 20),
                      // const Row(
                      //   children: [
                      //     Expanded(
                      //       child: Divider(
                      //         color: Colors.grey,
                      //         endIndent: 15,
                      //         thickness: 0.7,
                      //       ),
                      //     ),
                      //     Text(
                      //       'Hoặc đăng nhập bằng',
                      //       style: TextStyle(fontSize: 13),
                      //     ),
                      //     Expanded(
                      //       child: Divider(
                      //         color: Colors.grey,
                      //         indent: 15,
                      //         thickness: 0.7,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.asset(
                      //       imgFacebook,
                      //       height: 35,
                      //       width: 35,
                      //     ),
                      //     const SizedBox(
                      //       width: 30,
                      //     ),
                      //     Image.asset(
                      //       imgGoogle,
                      //       height: 35,
                      //       width: 35,
                      //     ),
                      //   ],
                      // ),
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
