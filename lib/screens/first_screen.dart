import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_chart/screens/login_screen.dart';
import 'package:test_chart/screens/register_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late double deviceSizeW;
  late double deviceSizeH;

  bool aniVisible = false;
  bool aniVisible02 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 1), () {
      aniVisible = true;
      setState(() {});
    });
    Timer(const Duration(milliseconds: 1001), () {
      aniVisible02 = true;
      setState(() {});
    });
  }

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

    PreferredSize appBar = PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        automaticallyImplyLeading: false,
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
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: deviceSizeH * 0.05,
            ),
            AnimatedOpacity(
              opacity: aniVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: Container(
                alignment: Alignment.bottomLeft,
                width: deviceSizeW * 0.9,
                height: deviceSizeH * 0.1,
                child: Text(
                  "쉽고 빠른 쇼핑의 시작\n카투와 함께",
                  style: TextStyle(
                    fontSize: fontSizeL,
                    color: const Color(0xFF474747),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: deviceSizeH * 0.01,
            ),
            AnimatedOpacity(
              opacity: aniVisible02 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: Container(
                alignment: Alignment.topLeft,
                width: deviceSizeW * 0.9,
                height: deviceSizeH * 0.1,
                child: Text(
                  "카트 상품 목록 생성부터\n쇼핑기록 관리, 소비 패턴 분석까지",
                  style: TextStyle(
                    fontSize: fontSizeML,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
            ),
            Container(
              height: deviceSizeH * 0.56,
            ),
            Container(
              alignment: Alignment.center,
              // color: Colors.amber,
              width: deviceSizeW * 0.9,
              height: deviceSizeH * 0.08,
              child: SizedBox(
                width: deviceSizeW * 0.9,
                height: deviceSizeH * 0.06,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FirstScreen()),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFF833D),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(deviceSizeW * 0.03)),
                    ),
                  ),
                  child: Text(
                    "시작하기",
                    style: TextStyle(
                      fontSize: fontSizeM,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // color: Colors.pink,
              alignment: Alignment.center,
              width: deviceSizeW * 0.9,
              height: deviceSizeH * 0.08,
              child: SizedBox(
                width: deviceSizeW * 0.5,
                height: deviceSizeH * 0.05,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstScreen(),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "이미 가입이 되어 있어요",
                        style: TextStyle(
                          fontSize: fontSizeS,
                          color: const Color(0xFF999999),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: deviceSizeW * 0.01),
                        width: deviceSizeW * 0.015,
                        child: SvgPicture.asset(
                            'assets/images/svg/arrow_gray.svg'),
                      ),
                    ],
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
    );
  }
}
