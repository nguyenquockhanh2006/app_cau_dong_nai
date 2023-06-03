import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_4/services/controllers/imageController.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<test> {
  final imageController iC = imageController();
  File? _imageFile;
  String? _hinhAnhCausrc;
  Future<void> _pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      final srcTemp = await iC.postImage(File(pickedFile.path));
      setState(() {
        _imageFile = File(pickedFile.path);
        _hinhAnhCausrc = srcTemp;
        print(_hinhAnhCausrc);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker Example')),
      body: Center(
        child: _imageFile == null
            ? const Text('No image selected.')
            : Image.file(_imageFile!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickImage(ImageSource.gallery),
        tooltip: 'Pick Image',
        child: const Icon(Icons.image),
      ),
    );
  }
}
//
// showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text('Thông báo'),
//                                 content: Text(
//                                     'cập nhật ${_controllerTenCayCau.text} thành công', style: TextStyle(color: Colors.green,), ),
//                                 actions: [
//                                   TextButton(
//                                     child: const Text('Đóng'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
                                  
//                                 ],
//                               );
//                             },
//                           );
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(),
//     body: WillPopScope(
//       child: Center(
//         child: RaisedButton(
//           child: Text('Go back'),
//           onPressed: () {
//             Navigator.pop(context); // hoặc xử lý hành động tại đây
//           },
//         ),
//       ),
//       onWillPop: () async {
//         // xử lý hành động khi ấn nút back
//         return true;
//       },
//     ),
//   );
// }
