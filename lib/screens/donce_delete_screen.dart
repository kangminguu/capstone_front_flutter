import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_chart/screens/mypage_screen.dart';

import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class DoneDeleteScreen extends StatefulWidget {
  const DoneDeleteScreen({super.key});

  @override
  State<DoneDeleteScreen> createState() => _DoneDeleteScreenState();
}

class _DoneDeleteScreenState extends State<DoneDeleteScreen> {
  late double deviceSizeW;
  late double deviceSizeH;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const DoneDeleteScreen()),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyPageScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final double statusBarSize = MediaQuery.of(context).padding.top;
    deviceSizeW = MediaQuery.of(context).size.width;
    deviceSizeH = MediaQuery.of(context).size.height;

    double fontSizeS = deviceSizeH * 0.015;
    double fontSizeM = deviceSizeH * 0.017;
    double fontSizeML = deviceSizeH * 0.02;
    double fontSizeL = deviceSizeH * 0.035;

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: deviceSizeW,
        height: deviceSizeH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceSizeH * 0.065,
              width: deviceSizeH * 0.07,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: deviceSizeH * 0.06,
                    child: SvgPicture.asset('assets/images/svg/person.svg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: WidgetAnimator(
                      atRestEffect: WidgetRestingEffects.bounce(),
                      child: SvgPicture.asset(
                        'assets/images/svg/correct.svg',
                        height: deviceSizeH * 0.03,
                        width: deviceSizeH * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: deviceSizeW * 0.55,
              child: Text(
                "삭제가 완료되었습니다.",
                style: TextStyle(
                  fontSize: fontSizeML,
                  color: const Color(0xFF474747),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
