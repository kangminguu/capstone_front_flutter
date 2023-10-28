import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../network/network.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:test_chart/screens/done_change_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late double deviceSizeW;
  late double deviceSizeH;
  Network network = Network();
  late String password;
  late String valPassword;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  late dynamic userInfo;
  late bool isFirst;
  late bool checkPassword;
  late String email;
  late String nick;
  late bool result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      userInfo = await storage.read(key: 'login');
      userInfo = jsonDecode(userInfo);
      email = userInfo['email'];
      nick = userInfo['nickname'];
    });
    password = "";
    valPassword = "";

    isFirst = true;
    checkPassword = false;
  }

  Future<bool> changePass(email, pass) async {
    return await network.changePass(email, pass);
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
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
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
                    "변경할 비밀번호를\n입력해주세요.",
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
                            "변경할 비밀번호",
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
                        height: deviceSizeH * 0.06,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: deviceSizeH * 0.06,
                              child: TextFormField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: true,
                                keyboardType: TextInputType.multiline,
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
                                  hintText: "영문 및 숫자, 특수문자 조합 8~16자리",
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
                            Positioned(
                              right: 0,
                              top: deviceSizeH * 0.015 +
                                  (deviceSizeH * (0.005 / 2)),
                              child: SizedBox(
                                height: isFirst ? 0 : deviceSizeH * 0.025,
                                child: SvgPicture.asset(checkPassword
                                    ? 'assets/images/svg/correct.svg'
                                    : 'assets/images/svg/incorrect.svg'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: deviceSizeH * 0.03,
                        child: Row(
                          children: [
                            Container(
                              width: deviceSizeW * 0.9 / 2,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "변경할 비밀번호 확인",
                                style: TextStyle(
                                  fontSize: fontSizeS,
                                  color: const Color(0xFF474747),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: deviceSizeW * 0.9 / 2,
                              alignment: Alignment.centerRight,
                              child: Text(
                                isFirst
                                    ? ""
                                    : (checkPassword ? "" : "잘못된 형식이에요"),
                                style: TextStyle(
                                  fontSize: fontSizeS,
                                  color: const Color(0xFFF57C75),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          bottom: deviceSizeH * 0.02,
                          top: deviceSizeH * 0.01,
                        ),
                        height: deviceSizeH * 0.06,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: deviceSizeH * 0.06,
                              child: TextFormField(
                                onChanged: (value) {
                                  valPassword = value;
                                },
                                obscureText: true,
                                keyboardType: TextInputType.multiline,
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
                                  hintText: "변경할 비밀번호 확인",
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
                            Positioned(
                              right: 0,
                              top: deviceSizeH * 0.015 +
                                  (deviceSizeH * (0.005 / 2)),
                              child: SizedBox(
                                height: isFirst ? 0 : deviceSizeH * 0.025,
                                child: SvgPicture.asset(checkPassword
                                    ? 'assets/images/svg/correct.svg'
                                    : 'assets/images/svg/incorrect.svg'),
                              ),
                            )
                          ],
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
                      onPressed: (password != "" && valPassword != "")
                          ? () async {
                              setState(() {});
                              isFirst = false;
                              ValPasswordForm()
                                      .valPassword(password, valPassword)
                                  ? checkPassword = true
                                  : checkPassword = false;
                              result = await changePass(email, valPassword);
                              if (checkPassword == true & result) {
                                await storage.delete(key: 'login');
                                await storage.write(
                                    key: 'login',
                                    value: jsonEncode({
                                      'email': email,
                                      'password': valPassword,
                                      'nickname': nick
                                    }));
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePasswordScreen()),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DoneChangeScreen()),
                                );
                              }
                            }
                          : null,
                      style: TextButton.styleFrom(
                        backgroundColor: (password != "" && valPassword != "")
                            ? const Color(0xFFFF833D)
                            : const Color(0xFFFFC19E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(deviceSizeW * 0.03)),
                        ),
                      ),
                      child: Text(
                        "변경 완료",
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

class ValPasswordForm {
  bool valPassword(String password, valPassword) {
    if (password.length >= 8 &&
        password.length <= 16 &&
        password.toString() == valPassword.toString()) {
      return RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+").hasMatch(password);
    } else {
      return false;
    }
  }
}
