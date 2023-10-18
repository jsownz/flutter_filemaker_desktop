import 'package:flutter/material.dart';
import 'package:flutter_filemaker_desktop/components/top_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TopBar(),
        const Expanded(
          child: Center(
            child: Text("Main Screen"),
          ),
        ),
      ],
    );
  }
}
