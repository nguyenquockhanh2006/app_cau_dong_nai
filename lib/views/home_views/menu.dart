import 'dart:ffi';

import 'package:app_cau_dong_nai/services/controllers/bridge_controller.dart';
import 'package:app_cau_dong_nai/services/models/bridge_model.dart';
import 'package:flutter/material.dart';
import 'package:app_cau_dong_nai/views/home_views/home.dart';
import 'package:app_cau_dong_nai/views/info_bridge_views/info_bridge_home.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Color.fromARGB(255, 24, 92, 255),
              ),
              backgroundColor: Colors.white,
              title: Text(
                'CẦU ĐỒNG NAI',
                style: TextStyle(color: Color.fromARGB(255, 24, 92, 255)),
              ),
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://i.imgur.com/78M9KfI.jpg'),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.disabled_by_default_outlined),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => home()),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Bản đồ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 250),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => info_bridge_home()),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Thông tin cầu',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 192),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () async {
                      bridge_controller b_r = new bridge_controller();

                      List<bridge_model> bridgeList = await b_r.getApi();
                      bridgeList.forEach((element) {
                        print(element.TenCayCau.toString());
                        print(element.KinhDo.toString());
                        print(element.ViDo.toString());
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Kiểm tra / Sửa chữa',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 135),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                //Divider(height: 1, color: Colors.grey),
              ],
            )
            //
            ));
  }
}
