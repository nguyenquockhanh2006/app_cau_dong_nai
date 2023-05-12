import 'dart:ffi';

import 'package:flutter/material.dart';

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
                      print('nhán bản đồ');
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
                      print('nhán thông tin cầu');
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
                    onTap: () {
                      print('nhán kiểm tra / sữa chữa');
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
