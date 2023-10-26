import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../network/network.dart';

import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:test_chart/screens/main_screen.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String date = "";
  late double deviceSizeW;
  late double deviceSizeH;
  Network network = Network();

  dynamic shoppings_dic = {};
  List shoppings = [];

  FlutterSecureStorage storage = const FlutterSecureStorage();
  dynamic userInfo;

  DateTime _selectedDate = DateTime.now();
  String _selectedYear = DateTime.now().year.toString();
  String _selectedMonth = DateTime.now().month.toString();
  String _selectedDay = DateTime.now().day.toString();
  int totalPrice = 0;
  int totalCount = 0;
  Shopping_info(String date) async {
    userInfo = await storage.read(key: 'login');
    userInfo = jsonDecode(userInfo);
    String email = userInfo['email'];

    shoppings_dic = await network.checkShopping(email, date);
    shoppings = shoppings_dic['result'];
    setState(() {
      totalPrice = 0;
      totalCount = 0;
      for (int i = 0; i < shoppings.length; i++) {
        int k = shoppings[i]['price'];
        int j = shoppings[i]['count'];

        totalPrice = totalPrice + k;
        totalCount = totalCount + j;
        print(shoppings);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Shopping_info("$_selectedYear-$_selectedMonth-$_selectedDay");
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

    // default appbar height
    PreferredSize appBar = PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        centerTitle: true,
        title: Text(
          "쇼핑 기록 확인",
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
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
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
            Container(
              height: deviceSizeH * 0.03,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(deviceSizeW * 0.05),
                ),
              ),
              height: deviceSizeH * 0.18,
              width: deviceSizeW * 0.9,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: deviceSizeH * 0.06 - 1,
                    width: deviceSizeW * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "$_selectedYear년 $_selectedMonth월 $_selectedDay일",
                              style: TextStyle(
                                fontSize: fontSizeML,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF474747),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Positioned(
                              right: 0,
                              top: ((deviceSizeH * 0.06 - 1) / 2) -
                                  ((deviceSizeH * 0.015) / 2),
                              child: SvgPicture.asset(
                                'assets/images/svg/arrow_gray.svg',
                                height: deviceSizeH * 0.015,
                              ),
                            ),
                            SizedBox(
                              height: deviceSizeH * 0.06 - 1,
                              width: deviceSizeW * 0.2,
                              child: TextButton(
                                onPressed: () async {
                                  selectDayDialog(
                                      context, fontSizeS, fontSizeM);
                                  date =
                                      "$_selectedYear-$_selectedMonth-$_selectedDay";

                                  setState(() {});
                                },
                                child: Text(
                                  "날짜 선택",
                                  style: TextStyle(
                                    fontSize: fontSizeS,
                                    color: const Color(0xFF999999),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                              totalCount.toString(),
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
                              NumberFormat(
                                      '###,###,###') // 천만 단위로 넘어가면 오버플로, 백단위로 제한
                                  .format(totalPrice),
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
            SizedBox(
              height: deviceSizeH * 0.71,
              child: shoppings.isEmpty
                  ? Opacity(
                      opacity: 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/svg/face_worry.svg',
                            height: deviceSizeH * 0.1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "아무 기록이 없어요",
                            style: TextStyle(
                              fontSize: fontSizeML,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF474747),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          for (int i = 0; i < shoppings.length; i++)
                            singleProductDetail(fontSizeM, i),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Column singleProductDetail(double fontSizeM, int i) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(deviceSizeW * 0.05),
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
                width: deviceSizeW * 0.85,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(deviceSizeW * 0.03),
                      ),
                      child: Image.network(
                        shoppings[i]['address'],
                        fit: BoxFit.fill,
                        height: deviceSizeW * 0.15,
                        width: deviceSizeW * 0.15,
                      ),
                    ),
                    Container(
                      width: deviceSizeW * 0.03,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: deviceSizeH * 0.01,
                          width: deviceSizeW * 0.345,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: deviceSizeH * 0.07,
                          width: deviceSizeW * 0.345,
                          child: Text(
                            shoppings[i]['product_name'],
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
                                      shoppings[i]['count'].toString(),
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
                                      NumberFormat(
                                              '###,###,###') // 천만 단위로 넘어가면 오버플로, 백단위로 제한
                                          .format(shoppings[i]['price']),
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

  Future<dynamic> selectDayDialog(
      BuildContext context, double fontSizeS, double fontSizeM) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(deviceSizeW * 0.05),
            ),
          ),
          contentPadding: EdgeInsets.all(deviceSizeW * 0),
          content: Container(
            height: deviceSizeH * 0.2,
            width: deviceSizeW * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(deviceSizeW * 0.05),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: deviceSizeH * 0.02,
                ),
                Container(
                  alignment: Alignment.center,
                  height: deviceSizeH * 0.12,
                  width: deviceSizeW * 0.7,
                  child: ScrollDatePicker(
                    selectedDate: _selectedDate,
                    locale: const Locale('ko'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        _selectedYear = value.year.toString();
                        _selectedMonth = value.month.toString();
                        _selectedDay = value.day.toString();
                        if (_selectedMonth.length < 2) {
                          _selectedMonth = "0$_selectedMonth";
                        }
                        if (_selectedDay.length < 2) {
                          _selectedDay = "0$_selectedDay";
                        }
                        date = "$_selectedYear-$_selectedMonth-$_selectedDay";
                        _selectedDate = DateTime.parse(date);
                      });
                    },
                    scrollViewOptions: const DatePickerScrollViewOptions(
                      year: ScrollViewDetailOptions(
                        label: '년',
                      ),
                      month: ScrollViewDetailOptions(
                        label: '월',
                      ),
                      day: ScrollViewDetailOptions(
                        label: '일',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceSizeH * 0.06,
                  width: deviceSizeW * 0.7,
                  child: TextButton(
                    onPressed: () async {
                      shoppings_dic = await Shopping_info(date);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0x00F2F4F6),
                    ),
                    child: Text(
                      "확인",
                      style: TextStyle(
                        color: const Color(0xFF474747),
                        fontSize: fontSizeM,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
