import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:test_chart/main.dart';
import 'package:test_chart/screens/detail_cart_screen.dart';
import 'package:test_chart/screens/main_screen.dart';
import '../network/network.dart';

List<CameraDescription> _cameras = ProvideCamera().cameras;
late CameraController controller;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late double deviceSizeW;
  late double deviceSizeH;
  dynamic result_dic = {};
  dynamic result = {};
  bool showHelpPage = false;
  bool showRecoPage = false;

  List product_name = [];
  List product_price = [];
  List product_count = [];
  List product_total = [];
  Network network = Network();
  // late CameraController controller;

  late int imageCount;

  @override
  void initState() {
    controller = CameraController(
      _cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    imageCount = 0;

    if (!controller.value.isInitialized) {
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
        imageStreamStart();
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              break;
            default:
              break;
          }
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    stopStearmController();
    super.dispose();
  }

  imageStreamStart() async {
    if (controller.value.isInitialized) {
      controller.startImageStream(
        (image) async {
          imageCount++;

          if (imageCount % 90 == 0) {
            imageCount = 0;
            result_dic = await network.Detection(image.planes[0].bytes,
                image.planes[1].bytes, image.planes[2].bytes);
            result = result_dic['result'];
            product_name = result['product_name'];

            product_price = result['product_price'];

            product_count = result['product_count'];

            for (int i = 0; i < product_price.length; i++) {
              int count = product_count[i];

              int price = product_price[i];
              int total = count * price;
              print(total.toString());
              product_total.add(total);
            }
            setState(() {});
          }
        },
      );
    }
  }

  imageStreamStop() {
    controller.stopImageStream();
    imageCount = 0;
  }

  stopStearmController() {
    controller.stopImageStream();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          SizedBox(
            height: statusBarSize,
          ),
          Stack(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    showRecoPage = true;
                  });
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.black,
                  height: deviceSizeH,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: SizedBox(
                          height: deviceSizeH * 0.79,
                          width: deviceSizeW,
                          child: CameraPreview(controller),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: deviceSizeH * 0.25,
                          width: deviceSizeW,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(deviceSizeW * 0.05),
                              topRight: Radius.circular(deviceSizeW * 0.05),
                            ),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showShoppingList(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: const Color(0xFFFFFFFF),
                                  height: deviceSizeH * 0.04,
                                  width: deviceSizeW * 0.2,
                                  child: Transform.rotate(
                                    angle: -math.pi / 2,
                                    child: SvgPicture.asset(
                                      'assets/images/svg/arrow.svg',
                                      height: deviceSizeH * 0.025,
                                      width: deviceSizeH * 0.025,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: deviceSizeH * 0.05 - 1,
                                width: deviceSizeW * 0.9,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: deviceSizeW * 0.4,
                                      child: Text(
                                        "상품명",
                                        style: TextStyle(
                                          fontSize: fontSizeS,
                                          color: const Color(0xFF474747),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: deviceSizeW * 0.25,
                                      child: Text(
                                        "가격",
                                        style: TextStyle(
                                          fontSize: fontSizeS,
                                          color: const Color(0xFF474747),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: deviceSizeW * 0.25,
                                      child: Text(
                                        "수량",
                                        style: TextStyle(
                                          fontSize: fontSizeS,
                                          color: const Color(0xFF474747),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1,
                                width: deviceSizeW * 0.9,
                                child: Row(
                                  children: [
                                    for (var i = 0; i < 30; i++)
                                      Row(
                                        children: [
                                          Container(
                                            color: const Color(0xFF999999),
                                            width: (deviceSizeW * 0.9) / 90,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: (deviceSizeW * 0.9) / 90,
                                          ),
                                          Container(
                                            color: const Color(0xFF999999),
                                            width: (deviceSizeW * 0.9) / 90,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                // color: Colors.green,
                                height: deviceSizeH * 0.08,
                                width: deviceSizeW * 0.9,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: deviceSizeW * 0.4,
                                      child: Text(
                                        (product_name.isEmpty)
                                            ? "-"
                                            : product_name[0],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: fontSizeM,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF474747),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: deviceSizeW * 0.25,
                                      child: Text(
                                        (product_price.isEmpty)
                                            ? ""
                                            : NumberFormat(
                                                    '###,###,###') // 천만 단위로 넘어가면 오버플로, 백단위로 제한
                                                .format(product_total[0]),
                                        style: TextStyle(
                                          fontSize: fontSizeM,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF474747),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: deviceSizeW * 0.25,
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: deviceSizeW * 0.1,
                                            width: deviceSizeW * 0.1,
                                            child: IconButton(
                                              onPressed: () {
                                                print("minus");
                                              },
                                              icon: SvgPicture.asset(
                                                'assets/images/svg/btn_minus.svg',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: deviceSizeW * 0.05,
                                            child: Text(
                                              (result.isEmpty)
                                                  ? ""
                                                  : product_count[0].toString(),
                                              style: TextStyle(
                                                fontSize: fontSizeM,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: deviceSizeW * 0.1,
                                            width: deviceSizeW * 0.1,
                                            child: IconButton(
                                              onPressed: () {
                                                print("plus");
                                              },
                                              icon: SvgPicture.asset(
                                                'assets/images/svg/btn_plus.svg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: deviceSizeH * 0.06,
                                width: deviceSizeW * 0.9,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CameraScreen(),
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailCartScreen(),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF833D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(deviceSizeW * 0.03),
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: deviceSizeH * 0.03,
                                    width: deviceSizeW * 0.9,
                                    child: Stack(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: deviceSizeH * 0.03,
                                          child: Text(
                                            "쇼핑 정보 기록하기",
                                            style: TextStyle(
                                              fontSize: fontSizeM,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: (deviceSizeH * 0.02) / 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: deviceSizeH * 0.03,
                                            width: deviceSizeH * 0.03,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(100),
                                              ),
                                            ),
                                            child: Text(
                                              result.length.toString(),
                                              style: TextStyle(
                                                fontSize: fontSizeM,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFFFF833D),
                                              ),
                                            ),
                                          ),
                                        )
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
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                color: const Color(0x00000000),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: Transform.rotate(
                        angle: math.pi,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CameraScreen()),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen()),
                            );
                          },
                          icon: SvgPicture.asset(
                            'assets/images/svg/arrow_white.svg',
                            height: deviceSizeH * 0.025,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSizeH * 0.08,
                      width: deviceSizeH * 0.08,
                      child: IconButton(
                        onPressed: () {
                          showHelpPage
                              ? showHelpPage = false
                              : showHelpPage = true;
                          setState(() {});
                        },
                        icon: SvgPicture.asset(
                          'assets/images/svg/help.svg',
                          height: deviceSizeH * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 60,
                left: deviceSizeW * 0.05,
                child: showRecoPage
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            showRecoPage = false;
                          });
                        },
                        child: Container(
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
                              SizedBox(
                                height: deviceSizeH * 0.08,
                                width: deviceSizeW * 0.85,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(deviceSizeW * 0.03),
                                      ),
                                      child: Image.network(
                                        'https://sitem.ssgcdn.com/63/97/26/item/1000026269763_i1_1100.jpg',
                                        fit: BoxFit.fill,
                                        height: deviceSizeW * 0.15,
                                        width: deviceSizeW * 0.15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: deviceSizeW * 0.025,
                                    ),
                                    SizedBox(
                                      width: deviceSizeW * 0.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topCenter,
                                            height: deviceSizeH * 0.03,
                                            width: deviceSizeW * 0.5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/svg/fireworks.svg',
                                                  height: deviceSizeH * 0.02,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "추천 상품",
                                                  style: TextStyle(
                                                    fontSize: fontSizeML,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xFFF57C75),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topCenter,
                                            height: deviceSizeH * 0.05,
                                            width: deviceSizeW * 0.5,
                                            child: Text(
                                              "하리보 골드 100pack(10kg)",
                                              style: TextStyle(
                                                fontSize: fontSizeM,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF474747),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: deviceSizeW * 0.025,
                                    ),
                                    SizedBox(
                                      width: deviceSizeW * 0.15,
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
                      )
                    : const SizedBox(),
              ),
              showHelpPage
                  ? GestureDetector(
                      onTap: () {
                        showHelpPage = false;
                        setState(() {});
                      },
                      child: Container(
                        color: const Color(0xC0000000),
                        height: deviceSizeH,
                        width: deviceSizeW,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "카트 전체를 촬영할 수 있도록 각도를 조절해 주세요.",
                                  style: TextStyle(
                                    fontSize: fontSizeM,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "촬영된 상품은 자동으로 목록에 추가됩니다.",
                                  style: TextStyle(
                                    fontSize: fontSizeM,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 50,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/svg/check.svg',
                                    height: deviceSizeH * 0.015,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "화면을 터치하여 도움말 끄기",
                                    style: TextStyle(
                                      fontSize: fontSizeM,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: deviceSizeH,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> showShoppingList(BuildContext context) {
    double fontSizeS = deviceSizeH * 0.015;
    double fontSizeM = deviceSizeH * 0.017;
    double fontSizeML = deviceSizeH * 0.02;
    double fontSizeL = deviceSizeH * 0.03;

    double modalHeight = deviceSizeH - 56;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(deviceSizeW * 0.05),
          topRight: Radius.circular(deviceSizeW * 0.05),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter bottomState) {
            return Container(
              height: modalHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(deviceSizeW * 0.05),
                  topRight: Radius.circular(deviceSizeW * 0.05),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: const Color(0xFFFFFFFF),
                      height: deviceSizeH * 0.04,
                      width: deviceSizeW * 0.2,
                      child: Transform.rotate(
                        angle: math.pi / 2,
                        child: SvgPicture.asset(
                          'assets/images/svg/arrow.svg',
                          height: deviceSizeH * 0.025,
                          width: deviceSizeH * 0.025,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceSizeH * 0.05 - 1,
                    width: deviceSizeW * 0.9,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: deviceSizeW * 0.4,
                          child: Text(
                            "상품명",
                            style: TextStyle(
                              fontSize: fontSizeS,
                              color: const Color(0xFF474747),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: deviceSizeW * 0.25,
                          child: Text(
                            "가격",
                            style: TextStyle(
                              fontSize: fontSizeS,
                              color: const Color(0xFF474747),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: deviceSizeW * 0.25,
                          child: Text(
                            "수량",
                            style: TextStyle(
                              fontSize: fontSizeS,
                              color: const Color(0xFF474747),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    width: deviceSizeW * 0.9,
                    child: Row(
                      children: [
                        for (var i = 0; i < 30; i++)
                          Row(
                            children: [
                              Container(
                                color: const Color(0xFF999999),
                                width: (deviceSizeW * 0.9) / 90,
                              ),
                              Container(
                                color: Colors.white,
                                width: (deviceSizeW * 0.9) / 90,
                              ),
                              Container(
                                color: const Color(0xFF999999),
                                width: (deviceSizeW * 0.9) / 90,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: modalHeight - (deviceSizeH * 0.27),
                    width: deviceSizeW * 0.9,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          for (int i = 0; i < product_name.length; i++)
                            singleProduct(
                              fontSizeM,
                              fontSizeS,
                              i,
                              bottomState,
                            )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    width: deviceSizeW * 0.9,
                    child: Row(
                      children: [
                        for (var i = 0; i < 30; i++)
                          Row(
                            children: [
                              Container(
                                color: const Color(0xFF999999),
                                width: (deviceSizeW * 0.9) / 90,
                              ),
                              Container(
                                color: Colors.white,
                                width: (deviceSizeW * 0.9) / 90,
                              ),
                              Container(
                                color: const Color(0xFF999999),
                                width: (deviceSizeW * 0.9) / 90,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: deviceSizeH * 0.04 - 1,
                    width: deviceSizeW * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "총 수량",
                          style: TextStyle(
                            fontSize: fontSizeM,
                            color: const Color(0xFF474747),
                          ),
                        ),
                        Text(
                          "총 금액",
                          style: TextStyle(
                            fontSize: fontSizeM,
                            color: const Color(0xFF474747),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: deviceSizeH * 0.04,
                    width: deviceSizeW * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "12개",
                          style: TextStyle(
                            fontSize: fontSizeML,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF474747),
                          ),
                        ),
                        Text(
                          "156,000원",
                          style: TextStyle(
                            fontSize: fontSizeML,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF474747),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: deviceSizeH * 0.02,
                  ),
                  SizedBox(
                    height: deviceSizeH * 0.06,
                    width: deviceSizeW * 0.9,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraScreen()),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailCartScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFF833D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(deviceSizeW * 0.03),
                          ),
                        ),
                      ),
                      child: Text(
                        "쇼핑 정보 기록하기",
                        style: TextStyle(
                          fontSize: fontSizeM,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: deviceSizeH * 0.02,
                  ),
                ],
              ),
            );
          },
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
                    "상품을 목록에서 삭제합니다.",
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
                          onPressed: () {},
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

  Column singleProduct(double fontSizeM, fontSizeS, int i, bottomState) {
    return Column(
      children: [
        SizedBox(
          height: deviceSizeH * 0.08,
          width: deviceSizeW * 0.9,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: deviceSizeW * 0.4,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: deviceSizeW * 0.08,
                      width: deviceSizeW * 0.08,
                      child: IconButton(
                        onPressed: () {
                          deleteDialog(context, fontSizeS, fontSizeM);
                          bottomState(() {
                            setState(() {});
                          });
                        },
                        icon: SvgPicture.asset(
                          'assets/images/svg/trashcan.svg',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: deviceSizeW * 0.02,
                    ),
                    SizedBox(
                      width: deviceSizeW * 0.3,
                      child: Text(
                        product_name[i],
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: fontSizeM,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF474747),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: deviceSizeW * 0.25,
                child: Text(
                  NumberFormat('###,###,###') // 천만 단위로 넘어가면 오버플로, 백단위로 제한
                      .format(product_total[i]),
                  style: TextStyle(
                    fontSize: fontSizeM,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: deviceSizeW * 0.25,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: deviceSizeW * 0.1,
                      width: deviceSizeW * 0.1,
                      child: IconButton(
                        onPressed: () {
                          print("minus");
                        },
                        icon: SvgPicture.asset(
                          'assets/images/svg/btn_minus.svg',
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: deviceSizeW * 0.05,
                      child: Text(
                        product_count[i].toString(),
                        style: TextStyle(
                          fontSize: fontSizeM,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF474747),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: deviceSizeW * 0.1,
                      width: deviceSizeW * 0.1,
                      child: IconButton(
                        onPressed: () {
                          print("plus");
                        },
                        icon: SvgPicture.asset(
                          'assets/images/svg/btn_plus.svg',
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
          color: const Color(0xFFF2F4F6),
          height: 1,
        ),
      ],
    );
  }
}
