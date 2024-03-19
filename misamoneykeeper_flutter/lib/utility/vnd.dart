import 'package:intl/intl.dart';

String formatCurrency(int? value) {
  if (value != null) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return formatCurrency.format(value);
  } else {
    throw Exception("Giá trị không hợp lệ để định dạng tiền tệ.");
  }
}
