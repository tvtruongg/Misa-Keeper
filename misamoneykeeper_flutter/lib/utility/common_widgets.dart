import 'package:flutter/material.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/utility/styles.dart';

Widget buttonBorderWidget(
    {@required image, @required title, @required content}) {
  return Expanded(
    flex: 1,
    child: TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              animationDuration: Duration.zero,
              splashFactory: NoSplash.splashFactory,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.grey, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10))
          .copyWith(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 11,
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                )
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            )
          ],
        ),
      ),
    ),
  );
}

Widget buttonMenu({
  @required text,
  @required text2,
  @required func,
}) {
  return TextButton(
    onPressed: () {
      func;
    },
    style: TextButton.styleFrom(
      animationDuration: Duration.zero,
      splashFactory: NoSplash.splashFactory,
    ).copyWith(
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  text2,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                  ),
                ),
                const Icon(
                  Icons.navigate_next,
                  color: Colors.grey,
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
          height: 0.3,
        ),
      ],
    ),
  );
}

void GetDialog() {
  Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Mỗi tháng bạn chỉ muốn chi tiêu cho việc Mua sắm 1.000.000 đ. Hãy tạo cho mình một hạn mữa \"Chi cho mua sắm\".",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Hãy tạo hạn mức chi ngay!',
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                    //Buttons
                    Center(
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          shadowColor: Colors.transparent,
                          foregroundColor: const Color(0xFFFFFFFF),
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(0, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Tạo hạn mức chi'.toUpperCase(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Center(
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          minimumSize: const Size(0, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Đóng'.toUpperCase(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// void GetDialogYesNo() {
//   Get.dialog(
//     Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(20),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Material(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 10),
//                       const Text(
//                         "Bạn có muốn xoá tài khoản không?",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       const SizedBox(height: 15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton(
//                             style: TextButton.styleFrom(
//                               elevation: 0,
//                               splashFactory: NoSplash.splashFactory,
//                               shadowColor: Colors.transparent,
//                               foregroundColor: const Color(0xFFFFFFFF),
//                               backgroundColor: Colors.red,
//                               minimumSize: const Size(0, 35),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: () {},
//                             child: Text(
//                               'Có'.toUpperCase(),
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           ElevatedButton(
//                             style: TextButton.styleFrom(
//                               elevation: 0,
//                               splashFactory: NoSplash.splashFactory,
//                               backgroundColor: Colors.blue,
//                               shadowColor: Colors.transparent,
//                               minimumSize: const Size(0, 35),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: () {
//                               Get.back();
//                             },
//                             child: Text(
//                               'Không'.toUpperCase(),
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ]),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget textFormField(
    {@required titleText, @required controller, @required enabled}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        titleText,
        style: TextStyle(
          fontFamily: sansRegular,
          fontWeight: FontWeight.w300,
          color: Colors.grey[600],
        ),
      ),
      TextFormField(
        controller: controller,
        enabled: enabled,
        validator: (value) {
          if (value == null || value.isEmpty) {
            // ignore: prefer_interpolation_to_compose_strings
            return 'Vui lòng nhập ' + titleText;
          }
          return null;
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
      const Divider(
        height: 0.5,
        thickness: 1.5,
      ),
      const SizedBox(height: 10),
    ],
  );
}
