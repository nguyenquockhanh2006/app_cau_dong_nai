import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter_application_4/services/models/imageSrc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_4/services/models/imageSrc.dart';
class infoBridge extends StatelessWidget {
  final bridgeModel bridgeModelTemp;

  const infoBridge({Key? key, required this.bridgeModelTemp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 190,
        // padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 147,
              height: 190,
              padding: const EdgeInsets.all(0.5),
              child: SingleChildScrollView(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bridgeModelTemp.TenCayCau,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Container(
                    //   height: 109.76,
                    //   width: 130.61,
                    //   child: //Image.network(
                    //     //imageSrc.getSrc()[bridgeModelTemp.BridgeId],

                    //     //height: 109.76,
                    //     //width: 130.61,
                    //     //fit: BoxFit.cover,
                    //   //),

                    // ),
                    Container(
                      height: 130.61 ,
                      width: 109.76,
                      child: CachedNetworkImage(
                        imageUrl: imageSrc.getSrc()[bridgeModelTemp.BridgeId],
                        //imageUrl: 'https://i.imgur.com/xNPQKS7.jpg',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Xử lý sự kiện khi nhấn button
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text(
                        "CHI TIẾT / CẬP NHẬT",
                        style: TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 37, 152, 247),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Xử lý sự kiện khi nhấn button
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text(
                        "XÓA CÂY CẦU",
                        style: TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 254, 2, 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 190,
              padding: const EdgeInsets.fromLTRB(3, 15, 2, 0),
              child: Column(
                children: [
                  Container(
                    height: 125,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Địa điểm: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      bridgeModelTemp.DiaDiem,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lí trình: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      bridgeModelTemp.LyTrinh,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Loại cầu: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      bridgeModelTemp.LoaiCau,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chiều dài(m): ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(bridgeModelTemp.ChieuDai),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chiều rộng(m): ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(bridgeModelTemp.ChieuRong),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 44,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngày khởi công: ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 37, 152, 247),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(bridgeModelTemp.NgayKhoiCong),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngày hoàn thành: ",
                              style: TextStyle(
                                color: Color.fromRGBO(134, 200, 141, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(bridgeModelTemp.NgayHoanThanh),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
