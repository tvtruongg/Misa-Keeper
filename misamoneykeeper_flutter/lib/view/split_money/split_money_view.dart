import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class SplitMoneyView extends StatefulWidget {
  const SplitMoneyView({super.key});

  @override
  State<SplitMoneyView> createState() => _SplitMoneyViewState();
}

class _SplitMoneyViewState extends State<SplitMoneyView> {
  final _moneyController = TextEditingController(text: '0');
  final TextEditingController _Quantity = TextEditingController(text: '0');
  double? result = 0;
  String? formatResult = '0';
  void calculateDivision() {
    int? quantity = int.parse(_Quantity.text);
    String moneyRP = _moneyController.text.replaceAll(".", "");
    double? money = double.tryParse(moneyRP);
    if (money != null && money != 0 && quantity != 0) {
      setState(() {
        result = money / quantity;
        final format = NumberFormat('###,###,###', 'vi-VI');
        formatResult = format.format(result);
      });
    } else {
      setState(() {
        formatResult = '0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Chia tiền',
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
        actions: [
          IconButton(
            onPressed: () {
              _moneyController.text = '0';
              _Quantity.text = '0';
              result = 0;
              setState(() {});
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 28,
              color: Colors.white,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Số tiền',
                        style: TextStyle(color: Colors.black54)),
                    TextFormField(
                      controller: _moneyController,
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      onTap: () => _moneyController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: _moneyController.value.text.length),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(
                            thousandSeparator: ThousandSeparator.Period,
                            useSymbolPadding: true,
                            mantissaLength: 0)
                      ], // Only numbers can be entered
                      style: const TextStyle(fontSize: 28),
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                    const Divider(
                      height: 0.8,
                      thickness: 0.8,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Số thành viên',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: _Quantity,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onTap: () => _Quantity.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: _Quantity.value.text.length),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Số người',
                        prefixIcon: Icon(Icons.group),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _moneyController.text = '0';
                          _Quantity.text = '0';
                          formatResult = '0';
                          setState(() {});
                        },
                        child: const Text('Reset')),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        onPressed: calculateDivision,
                        child: const Text('Kết quả')),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Số tiền khi chia:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text('$formatResult'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
