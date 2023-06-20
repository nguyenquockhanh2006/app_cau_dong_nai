import 'package:connectivity/connectivity.dart';

class internet {
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
          print('đang kết nối internet');
      return true;
    } else {
      print('không có kết nối internet');
      return false;
    }
  }
}
