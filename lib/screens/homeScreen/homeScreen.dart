import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/homeScreen/mapScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/listScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';

class home extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  home({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            title: const Text('CẦU ĐỒNG NAI'),
            toolbarHeight: 60,
            leading: Image.asset("lib/assets/images/Logo_Dong_Nai.png")),
        endDrawer: const menu(),
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
