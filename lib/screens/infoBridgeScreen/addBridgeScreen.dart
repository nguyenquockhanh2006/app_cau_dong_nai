import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/screens/homeScreen/mapScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/listScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';

class addBridgeScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    var index = 300;
    var index2 = index;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text('CẦU ĐỒNG NAI'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://i.imgur.com/vHZ2Ewl.png'),
          ),
        ),
        endDrawer: menu(),
        body: Column(
          children: [
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(1, 241, 81, 59)),
                  ),
                  onPressed: () => {},
                  child: Text('Quay lại'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                  ),
                  onPressed: () => {},
                  child: Text('Làm mới'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () => {},
                  child: Text('Thêm cầu mới'),
                ),
              ],
            ),
            Container(
              child: Column(
                children: [
                  Text('data'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
