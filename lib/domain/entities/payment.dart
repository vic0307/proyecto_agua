class Payment {
  const Payment(
      {required this.folio, required this.date, required this.total});
  final String folio;
  final DateTime date;
  final double total;
}
