String formatAmount(double amount) {
  // Ensure the amount has two decimal places
  String amountString = amount.toStringAsFixed(2);

  // Split the amount into integer and decimal parts
  List<String> parts = amountString.split('.');
  String integerPart = parts[0];
  String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

  // Add thousands separator to the integer part
  String formattedInteger = '';
  for (int i = 0; i < integerPart.length; i++) {
    if (i > 0 && (integerPart.length - i) % 3 == 0) {
      formattedInteger += ' ';
    }
    formattedInteger += integerPart[i];
  }

  return "$formattedInteger$decimalPart";
}
