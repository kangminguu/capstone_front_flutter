import 'package:flutter/material.dart';
import 'package:test_chart/screens/first_loading_screen.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Size deviceSize = const Size(1, 1);

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstLoadingScreen(),
    );
  }
}

class ProvideCamera extends ChangeNotifier {
  List<CameraDescription> get cameras => _cameras;
}
