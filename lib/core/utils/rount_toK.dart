import 'package:intl/intl.dart';

extension IntX on int {
  String roundToK() {
    return NumberFormat.compact().format(this);
  }

  int get roundToZero => this <= 0 ? 0 : this;
}
