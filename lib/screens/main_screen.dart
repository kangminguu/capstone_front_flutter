import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_chart/screens/camera_screen.dart';
import 'package:test_chart/screens/mypage_screen.dart';
import '../network/network.dart';
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

  dynamic category_change = {
    'milk_diaryProducts': '우유/유제품',
    'mealKit_convenienceMeal': '밀키트/간편식',
    'beverage': '음료',
    'cannedFood': '통조림',
    'noodles': '면류',
    'seasoning_oil': '양념/오일',
    'sweets_snacks': '스낵',
    'householdGoods_tools': '공구'
  };
  String nick = "";
  List money = ["0", "0", "0"];
  List category = ["", "", ""];
  String categoryEtc = "기타";
  List bought = ["0", "0", "0", "0"];
  int diff = 0;

  late bool isEmpty;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      dynamic userInfo = await storage.read(key: 'login');

      userInfo = jsonDecode(userInfo);

      Network network = Network();

      var result = await network.mainPage(userInfo['email']);

      money = result['totalprice'];
      category = result['category'];
      bought = result['bought'];
      nick = userInfo['nickname'];
      diff = result['diff'];
      setState(() {});
    });

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

    (bought[0] == '0') ? isEmpty = true : isEmpty = false;
    _chartData = getChartData();

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
                                    nick,
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
                                        builder: (context) => CameraScreen(
                                            const [],
                                            const [],
                                            const [],
                                            const [],
                                            0,
                                            0,
                                            const []),
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
                                    "${DateTime.now().month}월 총 쇼핑 금액은",
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      (money[0] != "0")
                                          ? NumberSlideAnimation(
                                              number: money[0],
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              curve: Curves.bounceIn,
                                              textStyle: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            )
                                          : const Text(""),
                                      (money[0] != "0")
                                          ? Text(
                                              ",",
                                              style: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            )
                                          : const Text(""),
                                      (money[1] != "0")
                                          ? NumberSlideAnimation(
                                              number: money[1],
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              curve: Curves.bounceIn,
                                              textStyle: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            )
                                          : const Text(""),
                                      (money[1] != "0")
                                          ? Text(
                                              ",",
                                              style: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            )
                                          : const Text(""),
                                      (money[2] != "0")
                                          ? NumberSlideAnimation(
                                              number: money[2],
                                              duration: const Duration(
                                                  milliseconds: 1750),
                                              curve: Curves.bounceIn,
                                              textStyle: TextStyle(
                                                fontSize: fontSizeL,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            )
                                          : Text(
                                              "0",
                                              style: TextStyle(
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
                                              NumberFormat(
                                                      '###,###,###') // 천만 단위로 넘어가면 오버플로, 백단위로 제한
                                                  .format(
                                                      diff > 0 ? diff : -diff),
                                              style: TextStyle(
                                                fontSize: fontSizeS,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                            Text(
                                              diff > 0
                                                  ? "원 을 더 소비했어요."
                                                  : "원 을 덜 소비했어요.",
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
                                    "${DateTime.now().month}월 가장 많이 구매한 품목",
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
                                      category_change[category[0]],
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
                                          category_change[category[0]] + "을 ",
                                          style: TextStyle(
                                            fontSize: fontSizeS,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        Text(
                                          bought[0].toString(),
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
                                                  isEmpty
                                                      ? "-"
                                                      : category_change[
                                                          category[0]],
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
                                                  isEmpty
                                                      ? "-"
                                                      : bought[0] + "회",
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
                                                  bought[1] == "0"
                                                      ? "-"
                                                      : category_change[
                                                          category[1]],
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
                                                  bought[1] == "0"
                                                      ? "-"
                                                      : bought[1] + "회",
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
                                                  bought[2] == "0"
                                                      ? "-"
                                                      : category_change[
                                                          category[2]],
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
                                                  bought[2] == "0"
                                                      ? "-"
                                                      : bought[2] + "회",
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
                                                  bought[3] == "0"
                                                      ? "-"
                                                      : categoryEtc,
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
                                                  bought[3] == "0"
                                                      ? "-"
                                                      : bought[3] + "회",
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
      DataForChart('others', int.parse(bought[3]), const Color(0xFFD6D6D6)),
      DataForChart('third', int.parse(bought[2]), const Color(0xFF979797)),
      DataForChart('second', int.parse(bought[1]), const Color(0xFF6B6B6B)),
      DataForChart('first', int.parse(bought[0]), const Color(0xFFFF833D)),
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
