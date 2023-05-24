import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/homeScreen/mapScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/listScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';

class home extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      //Có thể config style bằng theme
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text('CẦU ĐỒNG NAI'),
            toolbarHeight: 60, // Thay đổi kích thước của appBar
            leading: Image.asset("lib/assets/images/Logo_Dong_Nai.png")),
        endDrawer: menu(),
        //Nếu chỉ muốn thay kích thước thôi thì nên sử dụng "SizedBox"
        body: const SizedBox(
          child: flutter_map_load(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            navigatorKey.currentState?.push(
              MaterialPageRoute(builder: (context) => list_info_bridge()),
            ),
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.list),
        ),
      ),
    );
  }
}

class MyNewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My New Page')),
      body: Center(
        child: Text('This is my new page'),
      ),
    );
  }
}
