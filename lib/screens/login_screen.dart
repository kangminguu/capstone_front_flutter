import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_chart/screens/main_screen.dart';
import 'dart:math' as math;
import 'first_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double deviceSizeW;
  late double deviceSizeH;

  final String correctEmail = "aaaa";
  final String correctPassword = "aaaa";

  late String email;
  late String password;

  late bool isFirst;
  late bool checkLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    email = "";
    password = "";

    isFirst = true;
    checkLogin = false;
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
        leading: Transform.rotate(
          angle: math.pi,
          child: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FirstScreen()),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: deviceSizeH,
            width: deviceSizeW,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: deviceSizeH * 0.05,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: deviceSizeW * 0.9,
                  height: deviceSizeH * 0.1,
                  child: Text(
                    "더 많은 서비스를 위해\n로그인을 해주세요",
                    style: TextStyle(
                      fontSize: fontSizeL,
                      color: const Color(0xFF474747),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: deviceSizeH * 0.05,
                ),
                SizedBox(
                  height: deviceSizeH * 0.62,
                  width: deviceSizeW * 0.9,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: deviceSizeH * 0.03,
                        child: Container(
                          width: deviceSizeW * 0.9 / 2,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "이메일",
                            style: TextStyle(
                              fontSize: fontSizeS,
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          bottom: deviceSizeH * 0.02,
                          top: deviceSizeH * 0.01,
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: deviceSizeH * 0.06,
                              child: TextFormField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF2F4F6),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(deviceSizeW * 0.03)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFFF833D),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(deviceSizeW * 0.03)),
                                  ),
                                  hintText: "이메일",
                                  hintStyle: TextStyle(
                                    fontSize: fontSizeM,
                                    color: const Color(0xFFB7B7B7),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: fontSizeM,
                                  color: const Color(0xFF474747),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: deviceSizeH * 0.03,
                        child: Container(
                          width: deviceSizeW * 0.9 / 2,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "비밀번호",
                            style: TextStyle(
                              fontSize: fontSizeS,
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          bottom: deviceSizeH * 0.01,
                          top: deviceSizeH * 0.01,
                        ),
                        height: deviceSizeH * 0.06,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: deviceSizeH * 0.06,
                              child: TextFormField(
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF2F4F6),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(deviceSizeW * 0.03)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFFF833D),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(deviceSizeW * 0.03)),
                                  ),
                                  hintText: "비밀번호",
                                  hintStyle: TextStyle(
                                    fontSize: fontSizeM,
                                    color: const Color(0xFFB7B7B7),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: fontSizeM,
                                  color: const Color(0xFF474747),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        height: deviceSizeH * 0.18,
                        child: SizedBox(
                          child: Text(
                            isFirst ? "" : "로그인 정보가 올바르지 않습니다",
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
                Container(
                  alignment: Alignment.center,
                  width: deviceSizeW * 0.9,
                  height: deviceSizeH * 0.08,
                ),
                Container(
                  alignment: Alignment.center,
                  width: deviceSizeW * 0.9,
                  height: deviceSizeH * 0.08,
                  child: SizedBox(
                    width: deviceSizeW * 0.9,
                    height: deviceSizeH * 0.06,
                    child: TextButton(
                      onPressed: (email != "" && password != "")
                          ? () {
                              setState(() {});
                              print(CheckLoginForm()
                                  .checkEmail(email, correctEmail));
                              print(CheckLoginForm()
                                  .checkPassword(password, correctPassword));
                              isFirst = false;
                              if (CheckLoginForm()
                                          .checkEmail(email, correctEmail) ==
                                      true &&
                                  CheckLoginForm().checkPassword(
                                          password, correctPassword) ==
                                      true) {
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainScreen()),
                                );
                              }
                            }
                          : null,
                      style: TextButton.styleFrom(
                        backgroundColor: (email != "" && password != "")
                            ? const Color(0xFFFF833D)
                            : const Color(0xFFFFC19E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(deviceSizeW * 0.03)),
                        ),
                      ),
                      child: Text(
                        "로그인",
                        style: TextStyle(
                          fontSize: fontSizeM,
                          color: Colors.white,
                        ),
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
        ),
      ),
    );
  }
}

class CheckLoginForm {
  bool checkEmail(String email, correctEmail) {
    if (email == correctEmail) {
      return true;
    } else {
      return false;
    }
  }

  bool checkPassword(String password, correctPassword) {
    if (password == correctPassword) {
      return true;
    } else {
      return false;
    }
  }
}
