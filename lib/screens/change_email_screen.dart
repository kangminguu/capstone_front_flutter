import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:test_chart/screens/done_change_screen.dart';
import 'package:test_chart/screens/mypage_screen.dart';
import '../network/network.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  late double deviceSizeW;
  late double deviceSizeH;

  late String newEmail;
  String email = '';
  late String password;
  late String nick;
  late bool isFirst;
  late bool checkEmail;
  late bool result;

  Network network = Network();

  Future<bool> changeEmail(email, newEmail) async {
    return await network.changeEmail(email, newEmail);
  }

  late dynamic userInfo;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      userInfo = await storage.read(key: 'login');
      userInfo = jsonDecode(userInfo);
      email = userInfo['email'];
      setState(() {});
    });
    isFirst = true;
    checkEmail = false;
    setState(() {});
    newEmail = "";
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
                    builder: (context) => const ChangeEmailScreen()),
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
                    "변경하실 이메일을\n입력해주세요.",
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
                            "현재 이메일",
                            style: TextStyle(
                              fontSize: fontSizeS,
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          bottom: deviceSizeH * 0.02,
                          top: deviceSizeH * 0.01,
                        ),
                        child: Text(
                          email,
                          style: TextStyle(
                            fontSize: fontSizeM,
                            color: const Color(0xFF474747),
                          ),
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
                                "변경할 이메일",
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
                                    : (checkEmail
                                        ? (result ? "" : "중복된 이메일이에요")
                                        : "잘못된 형식이에요"),
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
                                  newEmail = value;
                                },
                                keyboardType: TextInputType.emailAddress,
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
                                  hintText: "변경할 이메일",
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
                                child: SvgPicture.asset(checkEmail
                                    ? 'assets/images/svg/correct.svg'
                                    : 'assets/images/svg/incorrect.svg'),
                              ),
                            ),
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
                      onPressed: (newEmail != "")
                          ? () async {
                              setState(() {});
                              result = await changeEmail(email, newEmail);

                              isFirst = false;
                              result ? checkEmail = true : checkEmail = false;
                              if (checkEmail == true) {
                                password = userInfo['password'];
                                nick = userInfo['nickname'];
                                storage.delete(key: 'login');
                                storage.write(
                                    key: 'login',
                                    value: jsonEncode({
                                      'email': newEmail,
                                      'password': password,
                                      'nickname': nick
                                    }));

                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangeEmailScreen()),
                                );
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyPageScreen()),
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
                        backgroundColor: (email != "")
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

class ValEmailForm {
  bool valEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
