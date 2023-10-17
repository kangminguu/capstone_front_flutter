import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_chart/screens/camera_screen.dart';
import 'package:test_chart/screens/mypage_screen.dart';

import 'history_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late double deviceSizeW;
  late double deviceSizeH;

  late List<DataForChart> _chartData;

  late String money1 = "3";
  late String money2 = "860";
  late String money3 = "400";

  bool isEmpty = false;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  DateTime? currentBackPressTime;

  // WillPopScope는 사용자가 백버튼을 눌렀을 때 동작
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    if (currentBackPressTime == null ||
        currentTime.difference(currentBackPressTime!) >
            const Duration(seconds: 2)) {
      currentBackPressTime = currentTime;
      Fluttertoast.showToast(
        msg: "한번 더 누르면 앱을 종료합니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFF474747),
        fontSize: 13,
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
    return true;

    SystemNavigator.pop();
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

    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Column(
          children: [
            Container(
              color: const Color(0xFFF2F4F6),
              height: statusBarSize,
            ),
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  isEmpty ? isEmpty = !isEmpty : isEmpty = !isEmpty;
                  _chartData = getChartData();
                  print(isEmpty.toString());
                });
              },
              child: Container(
                color: const Color(0xFFF2F4F6),
                height: deviceSizeH * 0.035,
              ),
            ),
            Container(
              color: const Color(0xFFF2F4F6),
              padding: EdgeInsets.only(
                left: deviceSizeW * 0.05,
                right: deviceSizeW * 0.05,
              ),
              height: deviceSizeH * 0.025,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: deviceSizeH * 0.12,
                    child:
                        SvgPicture.asset('assets/images/svg/app_logo_gray.svg'),
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              'assets/images/svg/my_info.svg',
                              height: deviceSizeH * 0.025,
                            ),
                          ),
                          SizedBox(
                            height: deviceSizeH * 0.025,
                            width: deviceSizeH * 0.025,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainScreen()),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyPageScreen()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFFB1B8C0),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                              child: const Text(""),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: const Color(0xFFF2F4F6),
              height: deviceSizeH * 0.02,
            ),
            Container(
              color: const Color(0xFFF2F4F6),
              width: deviceSizeW,
              height: deviceSizeH * 0.92,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        height: deviceSizeH * 0.15,
                        width: deviceSizeW * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(deviceSizeW * 0.05)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: deviceSizeH * 0.05,
                              width: deviceSizeW * 0.8,
                              child: Row(
                                children: [
                                  Text(
                                    "강만두",
                                    style: TextStyle(
                                      fontSize: fontSizeM,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF474747),
                                    ),
                                  ),
                                  Text(
                                    "님, 환영합니다.",
                                    style: TextStyle(
                                      fontSize: fontSizeM,
                                      color: const Color(0xFF474747),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: deviceSizeH * 0.1,
                              width: deviceSizeW * 0.8,
                              child: SizedBox(
                                height: deviceSizeH * 0.06,
                                width: deviceSizeW * 0.8,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScreen(),
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CameraScreen(),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFF2F4F6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(deviceSizeW * 0.03)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/svg/camera.svg',
                                        height: fontSizeM,
                                      ),
                                      Container(
                                        width: 7,
                                      ),
                                      Text(
                                        "카트 촬영하기",
                                        style: TextStyle(
                                          fontSize: fontSizeM,
                                          color: const Color(0xFF474747),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: const Color(0xFFF2F4F6),
                        height: deviceSizeH * 0.02,
                      ),
                      Container(
                        height: deviceSizeH * 0.25,
                        width: deviceSizeW * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(deviceSizeW * 0.05)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: deviceSizeH * 0.05,
                              width: deviceSizeW * 0.8,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: deviceSizeH * 0.02,
                                    child: SvgPicture.asset(
                                      'assets/images/svg/calculator.svg',
                                      width: deviceSizeH * 0.02,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "8월 총 쇼핑 금액은",
                                    style: TextStyle(
                                      fontSize: fontSizeM,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF474747),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: deviceSizeH * 0.12,
                              width: deviceSizeW * 0.8,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "0원",
                                              style: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            NumberSlideAnimation(
                                              number: money1,
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              curve: Curves.bounceIn,
                                              textStyle: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                            Text(
                                              ",",
                                              style: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                            NumberSlideAnimation(
                                              number: money2,
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              curve: Curves.bounceIn,
                                              textStyle: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                            Text(
                                              ",",
                                              style: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                            NumberSlideAnimation(
                                              number: money3,
                                              duration: const Duration(
                                                  milliseconds: 1750),
                                              curve: Curves.bounceIn,
                                              textStyle: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                            Text(
                                              "원",
                                              style: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  isEmpty
                                      ? Text(
                                          "아직 이번달 소비 내역이 없어요.",
                                          style: TextStyle(
                                            fontSize: fontSizeS,
                                            color: const Color(0xFF999999),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "지난 달 보다 ",
                                              style: TextStyle(
                                                fontSize: fontSizeS,
                                                color: const Color(0xFF999999),
                                              ),
                                            ),
                                            Text(
                                              "1,000",
                                              style: TextStyle(
                                                fontSize: fontSizeS,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                            Text(
                                              "원 을 더 소비했어요.",
                                              style: TextStyle(
                                                fontSize: fontSizeS,
                                                color: const Color(0xFF999999),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              height: deviceSizeH * 0.08,
                              width: deviceSizeW * 0.8,
                              child: SizedBox(
                                height: deviceSizeH * 0.045,
                                width: deviceSizeW * 0.45,
                                child: Stack(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen(),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HistoryScreen(),
                                          ),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Color(0xFFC8C8C8),
                                        ),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/svg/chart.svg',
                                            height: deviceSizeH * 0.015,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "쇼핑 기록 확인하기",
                                            style: TextStyle(
                                              fontSize: fontSizeS,
                                              color: const Color(0xFF999999),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: ((deviceSizeH * 0.045) / 2) -
                                          (deviceSizeH * 0.013) / 2,
                                      right: deviceSizeW * 0.025,
                                      child: SvgPicture.asset(
                                        'assets/images/svg/arrow_gray.svg',
                                        height: deviceSizeH * 0.013,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: const Color(0xFFF2F4F6),
                        height: deviceSizeH * 0.02,
                      ),
                      Container(
                        height: deviceSizeH * 0.45,
                        width: deviceSizeW * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(deviceSizeW * 0.05),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: deviceSizeH * 0.05,
                              width: deviceSizeW * 0.8,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: deviceSizeH * 0.03,
                                    child: SvgPicture.asset(
                                      'assets/images/svg/graph.svg',
                                      width: deviceSizeH * 0.03,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "8월 가장 많이 구매한 품목",
                                    style: TextStyle(
                                      fontSize: fontSizeM,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF474747),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: deviceSizeH * 0.07,
                              width: deviceSizeW * 0.8,
                              child: isEmpty
                                  ? Opacity(
                                      opacity: 0.5,
                                      child: Text(
                                        "없어요",
                                        style: TextStyle(
                                          fontSize: fontSizeL,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF474747),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "스낵",
                                      style: TextStyle(
                                        fontSize: fontSizeL,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF474747),
                                      ),
                                    ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              height: deviceSizeH * 0.05,
                              width: deviceSizeW * 0.8,
                              child: isEmpty
                                  ? Text(
                                      "아직 이번달 소비 내역이 없어요.",
                                      style: TextStyle(
                                        fontSize: fontSizeS,
                                        color: const Color(0xFF999999),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "스낵을 ",
                                          style: TextStyle(
                                            fontSize: fontSizeS,
                                            color: const Color(0xFF999999),
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
                                          "회로 가장 많이 구매했어요.",
                                          style: TextStyle(
                                            fontSize: fontSizeS,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            SizedBox(
                              height: deviceSizeH * 0.25,
                              width: deviceSizeW * 0.8,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: deviceSizeW * 0.35,
                                    child: SizedBox(
                                      width: deviceSizeW * 0.35,
                                      child: SfCircularChart(
                                        series: <CircularSeries>[
                                          DoughnutSeries<DataForChart, String>(
                                            dataSource: _chartData,
                                            pointColorMapper:
                                                (DataForChart data, _) =>
                                                    data.color,
                                            xValueMapper:
                                                (DataForChart data, _) =>
                                                    data.item,
                                            yValueMapper:
                                                (DataForChart data, _) =>
                                                    data.numVal,
                                            animationDuration: 1500.0,
                                            radius: '115%',
                                            innerRadius: '25%',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: deviceSizeW * 0.05,
                                  ),
                                  SizedBox(
                                    width: deviceSizeW * 0.4,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: deviceSizeH * 0.025,
                                        ),
                                        SizedBox(
                                          height: deviceSizeH * 0.05,
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFF833D),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          deviceSizeW * 0.015)),
                                                ),
                                                height: deviceSizeW * 0.07,
                                                width: deviceSizeW * 0.07,
                                              ),
                                              Container(
                                                width: deviceSizeW * 0.03,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: deviceSizeW * 0.2,
                                                child: Text(
                                                  isEmpty ? "-" : "스낵",
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color:
                                                        const Color(0xFF474747),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: deviceSizeW * 0.1,
                                                child: Text(
                                                  isEmpty ? "0회" : "12회",
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color:
                                                        const Color(0xFF474747),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceSizeH * 0.05,
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF6B6B6B),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          deviceSizeW * 0.015)),
                                                ),
                                                height: deviceSizeW * 0.07,
                                                width: deviceSizeW * 0.07,
                                              ),
                                              Container(
                                                width: deviceSizeW * 0.03,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: deviceSizeW * 0.2,
                                                child: Text(
                                                  isEmpty ? "-" : "냉동식품",
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color:
                                                        const Color(0xFF474747),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: deviceSizeW * 0.1,
                                                child: Text(
                                                  isEmpty ? "0회" : "5회",
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color:
                                                        const Color(0xFF474747),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceSizeH * 0.05,
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF979797),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          deviceSizeW * 0.015)),
                                                ),
                                                height: deviceSizeW * 0.07,
                                                width: deviceSizeW * 0.07,
                                              ),
                                              Container(
                                                width: deviceSizeW * 0.03,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: deviceSizeW * 0.2,
                                                child: Text(
                                                  isEmpty ? "-" : "생필품",
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color:
                                                        const Color(0xFF474747),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: deviceSizeW * 0.1,
                                                child: Text(
                                                  isEmpty ? "0회" : "4회",
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color:
                                                        const Color(0xFF474747),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceSizeH * 0.05,
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFD6D6D6),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          deviceSizeW * 0.015)),
                                                ),
                                                height: deviceSizeW * 0.07,
                                                width: deviceSizeW * 0.07,
                                              ),
                                              Container(
                                                width: deviceSizeW * 0.03,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: deviceSizeW * 0.2,
                                                child: Text(
                                                  isEmpty ? "-" : "기타",
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color:
                                                        const Color(0xFF474747),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: deviceSizeW * 0.1,
                                                child: Text(
                                                  isEmpty ? "0회" : "8회",
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color:
                                                        const Color(0xFF474747),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceSizeH * 0.025,
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
                        color: const Color(0xFFF2F4F6),
                        height: deviceSizeH * 0.02,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  List<DataForChart> getChartData() {
    final List<DataForChart> chartData = [
      DataForChart('others', 8, const Color(0xFFD6D6D6)),
      DataForChart('third', 4, const Color(0xFF979797)),
      DataForChart('second', 5, const Color(0xFF6B6B6B)),
      DataForChart('first', 12, const Color(0xFFFF833D)),
    ];

    final List<DataForChart> chartEmpty = [
      DataForChart('others', 1, const Color(0xFFD6D6D6)),
      DataForChart('third', 0, const Color(0xFF979797)),
      DataForChart('second', 0, const Color(0xFF6B6B6B)),
      DataForChart('first', 0, const Color(0xFFFF833D)),
    ];

    return isEmpty ? chartEmpty : chartData;
  }
}

class DataForChart {
  DataForChart(this.item, this.numVal, this.color);
  late String item;
  late int numVal;
  final Color color;
}
