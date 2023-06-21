import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/repairScreen/repairHomeScreenShow.dart';

class resultAdd extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final int ketqua;
  resultAdd({super.key, required this.ketqua});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('thêm kiểm tra / sửa chữa'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //ketqua == 1 ? Text('Thành công') : Text('Thất bại'),
            ketqua == 1
                ? Image.network(
                    'https://www.seekpng.com/png/detail/72-722839_success-save-success-png-icon.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  )
                : Image.network(
                    'https://icon-library.com/images/failed-icon/failed-icon-8.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),
            Text(
              'Đã xử lí xong, kiểm tra lại kết quả!',
              style: TextStyle(fontSize: 20),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => repairHomeScreenShow()),
                );
              },
              child: Text(
                'Quay lại',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
