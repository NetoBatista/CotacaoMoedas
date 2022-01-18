import 'package:intl/intl.dart';

class NumberUtility {
  final _formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR', name: 'BRL');
  String format(dynamic number) => double.parse(number) < 1 ? number : _formatCurrency.format(number);
}