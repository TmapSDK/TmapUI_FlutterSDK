import 'package:fluttertoast/fluttertoast.dart';

class CommonToast {
  static show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
