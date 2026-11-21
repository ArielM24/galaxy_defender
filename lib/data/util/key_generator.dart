class KeyGenerator {
  static int _counter = -1;
  static final int _base = DateTime.now().millisecondsSinceEpoch;
  static String generate({String prefix = ""}) {
    return "$prefix${_base}_${++KeyGenerator._counter}";
  }
}
