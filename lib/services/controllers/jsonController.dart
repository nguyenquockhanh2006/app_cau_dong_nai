import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
//http://171.244.8.103:9003/api/upload/from-react -- > post images
class jsonController {

  // http://171.244.8.103:9003/api/bridge/
  void writeApiAllBridge() async {
    final url = Uri.parse('http://171.244.8.103:9003/api/bridge/');
    final client = HttpClient();

    final response =
        await client.getUrl(url).then((request) => request.close());

    final jsonString = await response.transform(utf8.decoder).join();

    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/data.json';
    final file = File(path);

    await file.writeAsString(jsonString);

    print('Data saved to file at $path');
    print('Thành công');
  }
  // http://171.244.8.103:9003/api/bridge?keyword=&type=
  
  // http://171.244.8.103:9003/api/bridgeRepair/
}
