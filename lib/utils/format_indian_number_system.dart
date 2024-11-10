class FormatIndianNumberSystem {
  static String formatIndianNumber(int number) {
    String numStr = number.toString();
    int length = numStr.length;
    if (length <= 3) return numStr;
    String lastThree = numStr.substring(length - 3);
    String rest = numStr.substring(0, length - 3);
    var restWithCommas = rest.replaceAllMapped(
        RegExp(r'(\d)(?=(\d\d)+$)'), (Match match) => '${match[1]},');
    return '$restWithCommas,$lastThree';
  }
}
