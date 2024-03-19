import 'package:misamoneykeeper_flutter/controller/sc_money_view_model.dart';
import 'package:misamoneykeeper_flutter/model/sc_money.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RapView extends StatefulWidget {
  const RapView({super.key});

  @override
  State<RapView> createState() => _RapViewState();
}

class _RapViewState extends State<RapView> with TickerProviderStateMixin {
  late SCMoneyVM scMoneyVM;
  late List<SCMoney> data = [];
  late TooltipBehavior _tooltip;
  bool hasZeroValue = false;
  String showYear = "Chọn năm";
  DateTime _selectedYear = DateTime.now();
  selectYear(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Chọn năm"),
            content: SizedBox(
              height: 300,
              width: 300,
              child: YearPicker(
                  firstDate: DateTime(DateTime.now().year - 20),
                  lastDate: DateTime(DateTime.now().year + 50),
                  currentDate: _selectedYear,
                  selectedDate: _selectedYear,
                  onChanged: (DateTime dateTime) {
                    setState(() {
                      _selectedYear = dateTime;
                      print(_selectedYear);
                      scMoneyVM.txtYear = dateTime.year.toString();
                    });
                    fetchDataFromServer();
                    Navigator.pop(context);
                  }),
            ),
          );
        });
  }

  bool isListViewVisible = false;

  void toggleListViewVisibility() {
    setState(() {
      isListViewVisible = !isListViewVisible;
    });
  }

  @override
  void dispose() {
    Get.delete<SCMoneyVM>();
    super.dispose();
  }

  List<SCMoney> newData = [];
  List<SCMoney> positiveMonths = [];
  double maxValue = 40;
  double interval = 20;
  int maxExpense = 0;
  int maxRevenue = 0;
  int maxSum = 0;
  Future<void> fetchDataFromServer() async {
    List<SCMoney> newData = await scMoneyVM.serviceCallList();
    if (newData.any((element) =>
        element.pTotalRevenue != 0 || element.pTotalExpense != 0)) {
      positiveMonths = newData
          .where((element) =>
              element.pTotalExpense! > 0 || element.pTotalRevenue! > 0)
          .toList();
      maxExpense = newData
          .map((e) => e.pTotalExpense!)
          .reduce((value, element) => value > element ? value : element);
      maxRevenue = newData
          .map((e) => e.pTotalRevenue!)
          .reduce((value, element) => value > element ? value : element);
      if (maxExpense > maxRevenue) {
        maxValue = maxExpense / 1000; // Chia cho 1000 nếu cần đơn vị là nghìn
        interval = maxValue / 4;
        interval = (interval ~/ 10) * 10.0;
      } else {
        maxValue = maxRevenue / 1000; // Chia cho 1000 nếu cần đơn vị là nghìn
        interval = maxValue / 4;
        interval = (interval ~/ 10) * 10.0;
      }
      setState(() {});
    } else {
      setState(() {
        positiveMonths = [];
        maxValue = 40;
        interval = 10;
        maxExpense = 0;
        maxRevenue = 0;
      });
    }
  }

  @override
  void initState() {
    scMoneyVM = Get.put(SCMoneyVM());
    fetchDataFromServer();
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: FutureBuilder<List<SCMoney>>(
        // Gọi hàm fetchData() để nhận dữ liệu
        future: scMoneyVM.serviceCallList(),
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
            final List<SCMoney> data = snapshot.data!;
            // Đây là nơi bạn có thể sử dụng dữ liệu để hiển thị trên giao diện
            // Ví dụ: ListView.builder để hiển thị danh sách các tài khoản

            hasZeroValue = data.any((element) =>
                element.pTotalExpense != 0 || element.pTotalRevenue != 0);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () {
                        // Show year picker
                        selectYear(context);
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Năm ${scMoneyVM.txtYear}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Container(
                    color: Colors.white,
                    height: 400,
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            '(Đơn vị: Nghìn)',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: maxValue,
                                  interval: interval),
                              enableAxisAnimation: true,
                              tooltipBehavior: _tooltip,
                              enableSideBySideSeriesPlacement: false,
                              series: <CartesianSeries<SCMoney, String>>[
                                ColumnSeries<SCMoney, String>(
                                    dataSource: data,
                                    xValueMapper: (SCMoney data, _) =>
                                        data.pMonth.toString(),
                                    yValueMapper: (SCMoney data, _) =>
                                        (data.pTotalExpense)! / 1000,
                                    color:
                                        const Color.fromARGB(255, 19, 255, 59)),
                                ColumnSeries<SCMoney, String>(
                                    dataSource: data,
                                    opacity: 0.8,
                                    width: 0.4,
                                    xValueMapper: (SCMoney data, _) =>
                                        data.pMonth.toString(),
                                    yValueMapper: (SCMoney data, _) =>
                                        (data.pTotalRevenue)! / 1000,
                                    color:
                                        const Color.fromARGB(255, 243, 73, 73))
                              ],
                            ),
                            if (!hasZeroValue)
                              const Center(
                                child: Text(
                                  'Không có dữ liệu!',
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Tổng thu',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                color: Colors.green,
                                height: 15,
                                width: 15,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Tổng chi',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                color: Colors.red,
                                height: 15,
                                width: 15,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                          itemCount: positiveMonths
                              .length, // Set the number of items in the ListView
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1,
                              thickness: 1,
                            );
                          },
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tháng ${positiveMonths[index].pMonth}'),
                                const Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      formatCurrency(
                                          positiveMonths[index].pTotalExpense),
                                      style:
                                          TextStyle(color: Colors.green[400]),
                                    ),
                                    Text(
                                      formatCurrency(
                                          positiveMonths[index].pTotalRevenue),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      formatCurrency(positiveMonths[index]
                                              .pTotalExpense! -
                                          positiveMonths[index].pTotalRevenue!),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
