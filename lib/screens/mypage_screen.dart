import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_chart/screens/donce_delete_screen.dart';
import 'dart:math' as math;
import '../network/network.dart';

import 'package:test_chart/screens/change_email_screen.dart';
import 'package:test_chart/screens/change_nickname_screen.dart';
import 'package:test_chart/screens/change_passcheck_screen.dart';
import 'package:test_chart/screens/first_screen.dart';
import 'package:test_chart/screens/main_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  Network network = Network();
  late double deviceSizeW;
  late double deviceSizeH;
  late dynamic userInfo;
  String email = '';
  int password = 0;
  String nick = '';
  late bool result;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      userInfo = await storage.read(key: 'login');
      userInfo = jsonDecode(userInfo);
      email = userInfo['email'];
      password = userInfo['password'].length;
      nick = userInfo['nickname'];
      setState(() {});
    });
  }

  Future<bool> deleteHistory(email) async {
    return await network.deleteHistory(email);
  }

  Future<bool> deleteUser(email) async {
    return await network.deleteUser(email);
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
          "내 정보",
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
                MaterialPageRoute(builder: (context) => const MyPageScreen()),
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

    Future<bool> onWillPop() async {
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => const MyPageScreen(),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
      return true;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
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
                alignment: Alignment.centerLeft,
                height: deviceSizeH * 0.05,
                width: deviceSizeW * 0.8,
                child: Text(
                  "내 정보 변경",
                  style: TextStyle(
                    fontSize: fontSizeML,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(deviceSizeW * 0.05)),
                ),
                height: deviceSizeH * 0.3,
                width: deviceSizeW * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceSizeH * 0.015,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: deviceSizeH * 0.03,
                      width: deviceSizeW * 0.8,
                      child: Text(
                        "이메일",
                        style: TextStyle(
                          fontSize: fontSizeS,
                          color: const Color(0xFF999999),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.06,
                      width: deviceSizeW * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: fontSizeM,
                              color: const Color(0xFF474747),
                            ),
                          ),
                          SizedBox(
                            height: deviceSizeH * 0.045,
                            width: deviceSizeW * 0.15,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangeEmailScreen()),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF2F4F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(deviceSizeW * 0.03),
                                  ),
                                ),
                              ),
                              child: Text(
                                "변경",
                                style: TextStyle(
                                  fontSize: fontSizeS,
                                  color: const Color(0xFF474747),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: deviceSizeH * 0.03,
                      width: deviceSizeW * 0.8,
                      child: Text(
                        "비밀번호",
                        style: TextStyle(
                          fontSize: fontSizeS,
                          color: const Color(0xFF999999),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.06,
                      width: deviceSizeW * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "*" * password,
                            style: TextStyle(
                              fontSize: fontSizeM,
                              color: const Color(0xFF474747),
                            ),
                          ),
                          SizedBox(
                            height: deviceSizeH * 0.045,
                            width: deviceSizeW * 0.15,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePassCheckScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF2F4F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(deviceSizeW * 0.03),
                                  ),
                                ),
                              ),
                              child: Text(
                                "변경",
                                style: TextStyle(
                                  fontSize: fontSizeS,
                                  color: const Color(0xFF474747),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: deviceSizeH * 0.03,
                      width: deviceSizeW * 0.8,
                      child: Text(
                        "닉네임",
                        style: TextStyle(
                          fontSize: fontSizeS,
                          color: const Color(0xFF999999),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.06,
                      width: deviceSizeW * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            nick,
                            style: TextStyle(
                              fontSize: fontSizeM,
                              color: const Color(0xFF474747),
                            ),
                          ),
                          SizedBox(
                            height: deviceSizeH * 0.045,
                            width: deviceSizeW * 0.15,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangeNicknameScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF2F4F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(deviceSizeW * 0.03),
                                  ),
                                ),
                              ),
                              child: Text(
                                "변경",
                                style: TextStyle(
                                  fontSize: fontSizeS,
                                  color: const Color(0xFF474747),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  "시스템",
                  style: TextStyle(
                    fontSize: fontSizeML,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF474747),
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
                height: deviceSizeH * 0.27,
                width: deviceSizeW * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceSizeH * 0.015,
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.06,
                      width: deviceSizeW * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "로그아웃",
                            style: TextStyle(
                              fontSize: fontSizeM,
                              color: const Color(0xFF474747),
                            ),
                          ),
                          SizedBox(
                            height: deviceSizeH * 0.045,
                            width: deviceSizeW * 0.15,
                            child: TextButton(
                              onPressed: () {
                                logoutDialog(context, fontSizeS, fontSizeM);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF2F4F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(deviceSizeW * 0.03),
                                  ),
                                ),
                              ),
                              child: Text(
                                "확인",
                                style: TextStyle(
                                  fontSize: fontSizeS,
                                  color: const Color(0xFF474747),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.03,
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.06,
                      width: deviceSizeW * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "전체 기록 삭제",
                            style: TextStyle(
                              fontSize: fontSizeM,
                              color: const Color(0xFF474747),
                            ),
                          ),
                          SizedBox(
                            height: deviceSizeH * 0.045,
                            width: deviceSizeW * 0.15,
                            child: TextButton(
                              onPressed: () {
                                deleteDialog(context, fontSizeS, fontSizeM);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF2F4F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(deviceSizeW * 0.03),
                                  ),
                                ),
                              ),
                              child: Text(
                                "삭제",
                                style: TextStyle(
                                  fontSize: fontSizeS,
                                  color: const Color(0xFFF57C75),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.03,
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.06,
                      width: deviceSizeW * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "회원 탈퇴",
                            style: TextStyle(
                              fontSize: fontSizeM,
                              color: const Color(0xFF474747),
                            ),
                          ),
                          SizedBox(
                            height: deviceSizeH * 0.045,
                            width: deviceSizeW * 0.15,
                            child: TextButton(
                              onPressed: () {
                                withdrawDialog(context, fontSizeS, fontSizeM);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF2F4F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(deviceSizeW * 0.03),
                                  ),
                                ),
                              ),
                              child: Text(
                                "탈퇴",
                                style: TextStyle(
                                  fontSize: fontSizeS,
                                  color: const Color(0xFFF57C75),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.015,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> logoutDialog(
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
          contentPadding: const EdgeInsets.all(0),
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
                SizedBox(
                  height: deviceSizeH * 0.06,
                  child: SvgPicture.asset(
                    'assets/images/svg/alarm.svg',
                    height: deviceSizeH * 0.04,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: deviceSizeH * 0.06,
                  child: Text(
                    "로그아웃을 하시겠습니까?",
                    style: TextStyle(
                      fontSize: fontSizeM,
                      color: const Color(0xFF474747),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceSizeH * 0.06,
                  child: Row(
                    children: [
                      SizedBox(
                        height: deviceSizeH * 0.06,
                        width: deviceSizeW * 0.35,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0x00F2F4F6),
                          ),
                          child: Text(
                            "취소",
                            style: TextStyle(
                              color: const Color(0xFF474747),
                              fontSize: fontSizeM,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: deviceSizeH * 0.06,
                        width: deviceSizeW * 0.35,
                        child: TextButton(
                          onPressed: () {
                            storage.delete(key: 'login');
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyPageScreen()),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FirstScreen()),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0x00F66262),
                          ),
                          child: Text(
                            "로그아웃",
                            style: TextStyle(
                              color: const Color(0xFF5096FF),
                              fontSize: fontSizeM,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> deleteDialog(
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
                SizedBox(
                  height: deviceSizeH * 0.06,
                  child: SvgPicture.asset(
                    'assets/images/svg/alarm.svg',
                    height: deviceSizeH * 0.04,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: deviceSizeH * 0.06,
                  child: Text(
                    "저장된 모든 기록을 삭제합니다.",
                    style: TextStyle(
                      fontSize: fontSizeM,
                      color: const Color(0xFF474747),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceSizeH * 0.06,
                  child: Row(
                    children: [
                      SizedBox(
                        height: deviceSizeH * 0.06,
                        width: deviceSizeW * 0.35,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0x00F2F4F6),
                          ),
                          child: Text(
                            "취소",
                            style: TextStyle(
                              color: const Color(0xFF474747),
                              fontSize: fontSizeM,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: deviceSizeH * 0.06,
                        width: deviceSizeW * 0.35,
                        child: TextButton(
                          onPressed: () async {
                            result = await deleteHistory(email);
                            if (result) {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyPageScreen()),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DoneDeleteScreen()),
                              );
                            } else {}
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0x00F66262),
                          ),
                          child: Text(
                            "삭제",
                            style: TextStyle(
                              color: const Color(0xFFF66262),
                              fontSize: fontSizeM,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> withdrawDialog(
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
            height: deviceSizeH * 0.22,
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
                SizedBox(
                  height: deviceSizeH * 0.06,
                  child: SvgPicture.asset(
                    'assets/images/svg/face_sad.svg',
                    height: deviceSizeH * 0.04,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: deviceSizeH * 0.08,
                  child: Text(
                    "탈퇴하시면 기록된\n정보가 모두 삭제됩니다.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSizeM,
                      color: const Color(0xFF474747),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceSizeH * 0.06,
                  child: Row(
                    children: [
                      SizedBox(
                        height: deviceSizeH * 0.06,
                        width: deviceSizeW * 0.35,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0x00F2F4F6),
                          ),
                          child: Text(
                            "취소",
                            style: TextStyle(
                              color: const Color(0xFF474747),
                              fontSize: fontSizeM,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: deviceSizeH * 0.06,
                        width: deviceSizeW * 0.35,
                        child: TextButton(
                          onPressed: () async {
                            result = await deleteUser(email);
                            if (result) {
                              storage.delete(key: 'login');
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyPageScreen()),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FirstScreen()),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0x00F66262),
                          ),
                          child: Text(
                            "탈퇴",
                            style: TextStyle(
                              color: const Color(0xFFF66262),
                              fontSize: fontSizeM,
                            ),
                          ),
                        ),
                      ),
                    ],
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
