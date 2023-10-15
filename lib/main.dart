import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_filemaker_desktop/reusable/colors.dart';
import 'package:flutter_filemaker_desktop/screens/welcome_screen.dart';

void main() {
  runApp(const FlutterFilemakerDesktop());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1280, 720);
    win.minSize = const Size(600, 450);
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Flutter Filemaker for Desktop";
    win.show();
  });
}

const borderColor = MyColors.primary;

class FlutterFilemakerDesktop extends StatelessWidget {
  const FlutterFilemakerDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: borderColor,
          width: 1,
          child: const WelcomeScreen(),
        ),
      ),
    );
  }
}
