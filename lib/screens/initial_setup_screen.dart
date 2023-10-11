import 'package:flutter/material.dart';
import 'package:flutter_filemaker_desktop/components/top_bar.dart';
import 'package:flutter_filemaker_desktop/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialSetupScreen extends StatefulWidget {
  const InitialSetupScreen({super.key});

  @override
  State<InitialSetupScreen> createState() => _InitialSetupScreenState();
}

class _InitialSetupScreenState extends State<InitialSetupScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int? _connector = 0;
  String _appwriteUrl = "";
  String _appwriteProjectId = "";

  Future<void> _setDBConnectorOptions() async {
    final SharedPreferences prefs = await _prefs;
    switch (_connector) {
      case 0:
        prefs.setString('dbConnector', 'appwrite');
        prefs.setString('appwriteUrl', _appwriteUrl);
        prefs
            .setString('appwriteProjectId', _appwriteProjectId)
            .then((bool success) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
        });
        break;
    }
  }

  bool fieldsComplete() {
    switch (_connector) {
      case 0:
        return _appwriteUrl.isNotEmpty && _appwriteProjectId.isNotEmpty;
      case 1:
        // return _appwriteUrl.isNotEmpty && _appwriteProjectId.isNotEmpty;
        break;
      case 2:
        break;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 5.0,
            children: [
              // ChoiceChip(
              //   label: const Text('Local Sqlite3'),
              //   selected: _connector == 0,
              //   onSelected: (bool selected) {
              //     setState(() {
              //       _connector = selected ? 0 : null;
              //     });
              //   },
              // ),
              ChoiceChip(
                label: const Text('Appwrite'),
                selected: _connector == 0,
                onSelected: (bool selected) {
                  setState(() {
                    _connector = selected ? 0 : null;
                  });
                },
              ),
              // ChoiceChip(
              //   label: const Text('Firebase'),
              //   selected: _connector == 2,
              //   onSelected: (bool selected) {
              //     setState(() {
              //       _connector = selected ? 2 : null;
              //     });
              //   },
              // ),
            ],
          ),
          Visibility(
            visible: _connector == 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Column(
                children: [
                  TextField(
                    onChanged: (String value) {
                      setState(() {
                        _appwriteUrl = value;
                      });
                    },
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Appwrite Endpoint',
                      hintText: 'https://192.168.86.100:443',
                    ),
                  ),
                  TextField(
                    onChanged: (String value) {
                      setState(() {
                        _appwriteProjectId = value;
                      });
                    },
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Appwrite Project ID',
                      hintText: '652455d50e78ba93c555',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: !fieldsComplete()
                ? null
                : () async => {await _setDBConnectorOptions()},
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
