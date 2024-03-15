part of utils;

class NumberInputFormatter extends TextInputFormatter {
  final int? max;
  final int decimal;
  late final RegExp _exp;

  NumberInputFormatter({this.max, this.decimal = 2}) {
    if (decimal == 0) {
      _exp = RegExp(r'(^[1-9](\d+)?$)|(^(0)$)');
    } else {
      _exp = RegExp(
        r'(^[1-9](\d+)?$)|(^(0)$)|(^(0\.)(\d+)?(\d+)?$)|(^[1-9](\d+)?(\.)?(\d+)?$)',
      );
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final input = newValue.text;
    if (input.isEmpty) return newValue;
    if (!_exp.hasMatch(input)) return oldValue;
    if (max != null) {
      final num = double.tryParse(input) ?? 0;
      if (num > max!) {
        return TextEditingValue(
          text: max.toString(),
          selection: TextSelection.collapsed(offset: max.toString().length),
        );
      }
    }
    if (decimal > 0) {
      final index = input.indexOf('.');
      if (index < 0) return newValue;
      final afterDot = input.substring(index, input.length).length - 1;
      if (afterDot > decimal) return oldValue;
    }
    return newValue;
  }
}
