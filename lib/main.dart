import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_filemaker_desktop/reusable/colors.dart';
import 'package:flutter_filemaker_desktop/screens/welcome_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FlutterFilemakerDesktop(),
    ),
  );
}

const borderColor = MyColors.primary;

class FlutterFilemakerDesktop extends StatelessWidget {
  const FlutterFilemakerDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}
