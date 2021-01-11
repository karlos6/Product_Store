import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Control extends ChangeNotifier {
  String carlos = 'cas';

  get c {
    return this.carlos;
  }

  set optener(String n) {
    this.carlos = n;
    notifyListeners();
  }
}
