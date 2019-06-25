class Regular {
  static isMobile(String text) {
    RegExp exp = RegExp('^[1]([3-9])[0-9]{9}\$');
    return exp.hasMatch(text);
  }
}
