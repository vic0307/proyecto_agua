const _meses = [
  'ene', 'feb', 'mar', 'abr', 'may', 'jun',
  'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
];

String formatDate(DateTime d) => '${d.day} ${_meses[d.month - 1]} ${d.year}';

/// 1486 -> $1,486.00
String formatMoney(double v) {
  final parts = v.toStringAsFixed(2).split('.');
  final entero = parts[0]
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  return '\$$entero.${parts[1]}';
}
