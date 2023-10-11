import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:test_chart/screens/done_register_screen.dart';

class DetailCartScreen extends StatefulWidget {
  const DetailCartScreen({super.key});

  @override
  State<DetailCartScreen> createState() => _DetailCartScreenState();
}

class _DetailCartScreenState extends State<DetailCartScreen> {
  late double deviceSizeW;
  late double deviceSizeH;

  @override
  Widget build(BuildContext context) {
    // 상태바 사용
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    final double statusBarSize = MediaQuery.of(context).padding.top;
    deviceSizeW = MediaQuery.of(context).size.width;
    // 상단 상태바 빼고 높이
    deviceSizeH = MediaQuery.of(context).size.height - statusBarSize;

    double fontSizeS = deviceSizeH * 0.015;
    double fontSizeM = deviceSizeH * 0.017;
    double fontSizeML = deviceSizeH * 0.02;
    double fontSizeL = deviceSizeH * 0.03;

    // default appbar height
    PreferredSize appBar = PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        centerTitle: true,
        title: Text(
          "쇼핑 정보 기록",
          style: TextStyle(
            fontSize: fontSizeM,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF474747),
          ),
        ),
        leading: Transform.rotate(
          angle: math.pi,
          child: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailCartScreen()),
              );
            },
            icon: SvgPicture.asset(
              'assets/images/svg/arrow.svg',
              height: deviceSizeH * 0.025,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );

    // 상단 상태바 빼고 높이
    deviceSizeH = deviceSizeH - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: deviceSizeH,
        width: deviceSizeW,
        color: const Color(0xFFF2F4F6),
        child: Column(
          children: [
            SizedBox(
              height: deviceSizeH * 0.84,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: deviceSizeH * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(deviceSizeW * 0.03)),
                      ),
                      height: deviceSizeH * 0.18,
                      width: deviceSizeW * 0.9,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: deviceSizeH * 0.06 - 1,
                            width: deviceSizeW * 0.8,
                            child: Text(
                              "최종 정보",
                              style: TextStyle(
                                fontSize: fontSizeML,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF474747),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                            width: deviceSizeW * 0.8,
                            child: Row(
                              children: [
                                for (var i = 0; i < 30; i++)
                                  Row(
                                    children: [
                                      Container(
                                        color: const Color(0xFF999999),
                                        width: (deviceSizeW * 0.8) / 90,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: (deviceSizeW * 0.8) / 90,
                                      ),
                                      Container(
                                        color: const Color(0xFF999999),
                                        width: (deviceSizeW * 0.8) / 90,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.amber,
                            height: deviceSizeH * 0.02,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: deviceSizeH * 0.04,
                            width: deviceSizeW * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "총 상품 수량",
                                  style: TextStyle(
                                    fontSize: fontSizeM,
                                    color: const Color(0xFF474747),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "12",
                                      style: TextStyle(
                                        fontSize: fontSizeM,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF474747),
                                      ),
                                    ),
                                    Text(
                                      "개",
                                      style: TextStyle(
                                        fontSize: fontSizeM,
                                        color: const Color(0xFF474747),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: deviceSizeH * 0.04,
                            width: deviceSizeW * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "총 상품 금액",
                                  style: TextStyle(
                                    fontSize: fontSizeM,
                                    color: const Color(0xFF474747),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "156,000",
                                      style: TextStyle(
                                          fontSize: fontSizeM,
                                          fontWeight: FontWeight.bold,
                                          // color: const Color(0xFF474747),
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "원",
                                      style: TextStyle(
                                        fontSize: fontSizeM,
                                        color: const Color(0xFF474747),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.amber,
                            height: deviceSizeH * 0.02,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: deviceSizeH * 0.03,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: deviceSizeH * 0.05,
                      width: deviceSizeW * 0.8,
                      child: Text(
                        "쇼핑 상품 상세 내역",
                        style: TextStyle(
                          fontSize: fontSizeML,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF474747),
                        ),
                      ),
                    ),
                    singleProductDetail(fontSizeM),
                    singleProductDetail(fontSizeM),
                    singleProductDetail(fontSizeM),
                    singleProductDetail(fontSizeM),
                    singleProductDetail(fontSizeM),
                    singleProductDetail(fontSizeM),
                    singleProductDetail(fontSizeM),
                    singleProductDetail(fontSizeM),
                    singleProductDetail(fontSizeM),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(deviceSizeW * 0.05),
                ),
              ),
              height: deviceSizeH * 0.16,
              child: Column(
                children: [
                  SizedBox(
                    height: deviceSizeH * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "총 ",
                              style: TextStyle(
                                fontSize: fontSizeS,
                                color: const Color(0xFF474747),
                              ),
                            ),
                            Text(
                              "12",
                              style: TextStyle(
                                fontSize: fontSizeS,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF474747),
                              ),
                            ),
                            Text(
                              "개 상품, ",
                              style: TextStyle(
                                fontSize: fontSizeS,
                                color: const Color(0xFF474747),
                              ),
                            ),
                            Text(
                              "156,000",
                              style: TextStyle(
                                fontSize: fontSizeS,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF474747),
                              ),
                            ),
                            Text(
                              "원 상당의 상품을",
                              style: TextStyle(
                                fontSize: fontSizeS,
                                color: const Color(0xFF474747),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "카트에 담았습니다.",
                          style: TextStyle(
                            fontSize: fontSizeS,
                            color: const Color(0xFF474747),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceSizeH * 0.06,
                    width: deviceSizeW * 0.9,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailCartScreen(),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoneRegisterScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFF833D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(deviceSizeW * 0.03),
                          ),
                        ),
                      ),
                      child: Text(
                        "기록하기",
                        style: TextStyle(
                          fontSize: fontSizeM,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: deviceSizeH * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column singleProductDetail(double fontSizeM) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(deviceSizeW * 0.03),
            ),
          ),
          height: deviceSizeH * 0.1,
          width: deviceSizeW * 0.9,
          child: Column(
            children: [
              Container(
                height: deviceSizeH * 0.01,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: deviceSizeH * 0.08,
                width: deviceSizeW * 0.8,
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: deviceSizeH * 0.01,
                          width: deviceSizeW * 0.5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: deviceSizeH * 0.07,
                          width: deviceSizeW * 0.5,
                          child: Text(
                            "롯데 말랑카우 오리지널(70g)",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: fontSizeM,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: deviceSizeW * 0.03,
                    ),
                    SizedBox(
                      width: deviceSizeW * 0.27,
                      child: Column(
                        children: [
                          Container(
                            height: deviceSizeH * 0.01,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            height: deviceSizeH * 0.03,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "수량",
                                  style: TextStyle(
                                    fontSize: fontSizeM,
                                    color: const Color(0xFF474747),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "2",
                                      style: TextStyle(
                                        fontSize: fontSizeM,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF474747),
                                      ),
                                    ),
                                    Text(
                                      "개",
                                      style: TextStyle(
                                        fontSize: fontSizeM,
                                        color: const Color(0xFF474747),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: deviceSizeH * 0.04,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "금액",
                                  style: TextStyle(
                                    fontSize: fontSizeM,
                                    color: const Color(0xFF474747),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "6,250",
                                      style: TextStyle(
                                        fontSize: fontSizeM,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF474747),
                                      ),
                                    ),
                                    Text(
                                      "원",
                                      style: TextStyle(
                                        fontSize: fontSizeM,
                                        color: const Color(0xFF474747),
                                      ),
                                    ),
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
              Container(
                height: deviceSizeH * 0.01,
              ),
            ],
          ),
        ),
        Container(
          height: deviceSizeH * 0.02,
        ),
      ],
    );
  }
}
