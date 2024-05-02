class QRCodeFormater {
  static String toViewFormat(String qrCode) {
    int indexNonMatch = 0;
    final dashes = {1, 2};
    String qrcodeFormated = qrCode.splitMapJoin(RegExp('...'), onNonMatch: (s) => dashes.contains(indexNonMatch++) ? '-' : '');
    return qrcodeFormated;
  }
}
