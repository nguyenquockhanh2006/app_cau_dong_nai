import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';
import 'package:flutter_application_4/screens/repairScreen/addRepairScreen.dart';
import 'package:flutter_application_4/screens/repairScreen/repairHomeScreen.dart';

class repairHomeScreenShow extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  repairHomeScreenShow({super.key});
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            navigatorKey.currentState?.push(
              MaterialPageRoute(builder: (context) => addRepairScreen()),
            ),
          },
          backgroundColor: Colors.blue,
          tooltip: '',
          child: const Icon(Icons.add),
        ),
        body: repairHomeScreen(),
      ),
    );
  }
}
