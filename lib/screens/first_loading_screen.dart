import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_chart/screens/first_screen.dart';

class FirstLoadingScreen extends StatefulWidget {
  const FirstLoadingScreen({super.key});

  @override
  State<FirstLoadingScreen> createState() => _FirstLoadingScreenState();
}

class _FirstLoadingScreenState extends State<FirstLoadingScreen> {
  late double deviceSizeW;
  late double deviceSizeH;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pop(context,
          MaterialPageRoute(builder: (context) => const FirstLoadingScreen()));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FirstScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // final double statusBarSize = MediaQuery.of(context).padding.top;
    deviceSizeW = MediaQuery.of(context).size.width;
    deviceSizeH = MediaQuery.of(context).size.height;

    double fontSizeS = deviceSizeH * 0.015;
    double fontSizeM = deviceSizeH * 0.017;
    double fontSizeL = deviceSizeH * 0.035;

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: deviceSizeW,
        height: deviceSizeH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: deviceSizeW * 0.45,
              child:
                  SvgPicture.asset('assets/images/svg/app_logo_with_title.svg'),
            ),
            Container(
              alignment: Alignment.center,
              width: deviceSizeW * 0.55,
              child: Text(
                "쉽고 빠른 쇼핑의 시작, 카투",
                style: TextStyle(
                  fontSize: fontSizeM,
                  color: const Color(0xFF474747),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: deviceSizeH * 0.01),
              width: deviceSizeW * 0.55,
              child: Text(
                "카트 상품 목록 생성부터",
                style: TextStyle(
                  fontSize: fontSizeS,
                  color: const Color(0xFF999999),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: deviceSizeW * 0.55,
              child: Text(
                "쇼핑 키록 관리, 소비 패턴 분석까지",
                style: TextStyle(
                  fontSize: fontSizeS,
                  color: const Color(0xFF999999),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
