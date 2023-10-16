// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filemaker_desktop/screens/initial_setup_screen.dart';
import 'package:flutter_filemaker_desktop/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<bool> showSetupPage() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    String? dbConnector = sharedPreferences.getString('dbConnector');

    return dbConnector != null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: showSetupPage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return const MainScreen();
          }
          return const InitialSetupScreen();
        } else {
          return const InitialSetupScreen();
        }
      },
    );
  }
}
