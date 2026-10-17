/// Validadores con mensajes en lenguaje simple.
String? validateName(String? v) => (v == null || v.trim().length < 3)
    ? 'Escriba su nombre o el de su familia'
    : null;

String? validateContract(String? v) => (v == null || v.trim().length < 4)
    ? 'Escriba su número de contrato (viene en su recibo)'
    : null;

String? validateAddress(String? v) => (v == null || v.trim().length < 5)
    ? 'Escriba su dirección para poder atenderle'
    : null;

String? validatePhone(String? v) =>
    (v == null || v.length != 10) ? 'Escriba su teléfono de 10 números' : null;

String? validateAmount(String? v) {
  final n = double.tryParse((v ?? '').replaceAll(',', ''));
  return (n == null || n <= 0) ? 'Escriba el monto de su recibo' : null;
}
