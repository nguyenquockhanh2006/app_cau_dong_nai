import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/addBridgeScreen.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/listInfoBridge.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/test.dart';


class infoBridgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        endDrawer: menu(),
        appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            title: const Text('CẦU ĐỒNG NAI'),
            toolbarHeight: 60,
            leading: Image.asset("lib/assets/images/Logo_Dong_Nai.png")),
        body: listInfoBridge(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {
            navigatorKey.currentState?.push(
              MaterialPageRoute(builder: (context) => addBridgeScreen()),
              //MaterialPageRoute(builder: (context) => test()),
            ),
          },
          label: Text('Thêm cầu'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        
      ),
    );
  }
}
