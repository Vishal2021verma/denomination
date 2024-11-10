class FormatIndianNumberSystem {
  static String formatIndianNumber(int number) {
    String numStr = number.toString();
    int length = numStr.length;

    if (length <= 3) return numStr; // No commas needed for numbers <= 999

    String lastThree = numStr.substring(length - 3);
    String rest = numStr.substring(0, length - 3);

    // Insert commas every two digits from the right for the rest of the string
    var restWithCommas = rest.replaceAllMapped(
        RegExp(r'(\d)(?=(\d\d)+$)'), (Match match) => '${match[1]},');

    // Combine the formatted parts
    return '$restWithCommas,$lastThree';
  }
}
