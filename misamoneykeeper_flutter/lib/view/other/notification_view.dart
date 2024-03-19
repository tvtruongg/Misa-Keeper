import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/controller/notification_view_model.dart';
import 'package:misamoneykeeper_flutter/model/notification.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late NotificationVM notificationVM;
  DateFormat format = DateFormat('yyyy-MM-dd');
  @override
  void initState() {
    notificationVM = Get.put(NotificationVM());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Thông báo',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ),
        body: FutureBuilder<List<NotificationMD>>(
          // Gọi hàm fetchData() để nhận dữ liệu
          future: notificationVM.serviceCallList(),
          builder: (context, snapshot) {
            // Kiểm tra trạng thái của Future
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Nếu Future đang chờ dữ liệu, hiển thị một tiêu đề loading
              return Center(child: loadingIndicator());
            } else if (snapshot.hasError) {
              // Nếu có lỗi xảy ra trong quá trình lấy dữ liệu, hiển thị một thông báo lỗi
              return Text('Error: ${snapshot.error}');
            } else {
              // Nếu dữ liệu đã sẵn có, hiển thị dữ liệu lên giao diện
              final List<NotificationMD> data = snapshot.data!;
              // Đây là nơi bạn có thể sử dụng dữ liệu để hiển thị trên giao diện

              // Ví dụ: ListView.builder để hiển thị danh sách các tài khoản
              return ListView.separated(
                itemCount: data.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      title: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0,
                          padding: const EdgeInsets.all(0),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(8), // Border radius
                                child: Image.asset(
                                  icLogo,
                                  scale: 0.8,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data[index].textN}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${DateTime.parse(data[index].created!).day}/${DateTime.parse(data[index].created!).month}/${DateTime.parse(data[index].created!).year}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              );
            }
          },
        ));
  }
}
