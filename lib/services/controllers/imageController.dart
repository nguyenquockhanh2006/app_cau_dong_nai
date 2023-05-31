import 'dart:async';
import 'package:flutter_application_4/services/models/storedFilePath.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class imageController {
  Future<String?> postImage(File imageFile) async {
    final uri = Uri.parse('http://171.244.8.103:9003/api/upload/from-react');
    final request = http.MultipartRequest('POST', uri);
    final fileStream = http.ByteStream(imageFile.openRead());
    final fileLength = await imageFile.length();
    final multipartFile = http.MultipartFile(
      'file',
      fileStream,
      fileLength,
      filename: imageFile.path,
    );
    request.files.add(multipartFile);
    final response = await request.send();
    if (response.statusCode == 200) {
      final jsonString = await response.stream.bytesToString();
      final jsonMap = json.decode(jsonString);
      final storedFilePath = StoredFilePath.fromJson(jsonMap);
      print(
          'Upload successful with stored file path: ${storedFilePath.storedFilePath}');
      return storedFilePath.storedFilePath;
    } else {
      print('Upload failed with code ${response.statusCode}');
      return null;
    }
  }
}
