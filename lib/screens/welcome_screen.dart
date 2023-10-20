// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filemaker_desktop/models/db_connection.dart';
import 'package:flutter_filemaker_desktop/screens/initial_setup_screen.dart';
import 'package:flutter_filemaker_desktop/screens/main_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Future<bool> showSetupPage() async {
  //   var sharedPreferences = await SharedPreferences.getInstance();

  //   String? dbConnector = sharedPreferences.getString('dbConnector');

  //   return dbConnector != null;
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<bool>(
  //     future: showSetupPage(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         if (snapshot.data!) {
  //           return const MainScreen();
  //         }
  //         return const InitialSetupScreen();
  //       } else {
  //         return const InitialSetupScreen();
  //       }
  //     },
  //   );
  // }
  late var connectionDatabase;
  int? _connector = 0;
  String _connectionName = "";
  String _databaseName = "";
  String _connectionUri = "";
  String _appId = "";

  Future<void> _setDBConnectorOptions() async {
    switch (_connector) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  bool fieldsComplete() {
    switch (_connector) {
      case 0:
        break;
      case 1:
        return _connectionUri.isNotEmpty && _appId.isNotEmpty;
      case 2:
        break;
    }
    return false;
  }

  void setupDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final connectionDatabase = openDatabase(
      join(await getDatabasesPath(), 'connection_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE connections(id INTEGER PRIMARY KEY, connection_name TEXT, type INTEGER, database_name TEXT, connection_uri TEXT, app_id TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<DBConnection>> getConnections() async {
    // Get a reference to the database.
    final db = await connectionDatabase;

    // Query the table for all connections.
    final List<Map<String, dynamic>> savedConnections =
        await db.query('connections');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(savedConnections.length, (i) {
      return DBConnection(
        id: savedConnections[i]['id'],
        connection_name: savedConnections[i]['connection_name'],
        type: savedConnections[i]['type'],
        database_name: savedConnections[i]['database_name'],
        connection_uri: savedConnections[i]['connection_uri'],
        app_id: savedConnections[i]['app_id'],
      );
    });
  }

  Future<void> insertConnection(DBConnection connection) async {
    // Get a reference to the database.
    final db = await connectionDatabase;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'connections',
      connection.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  void initState() {
    setupDatabase();
    getConnections();
    super.initState();
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
              ChoiceChip(
                label: const Text('Local Sqlite3'),
                selected: _connector == 0,
                onSelected: (bool selected) {
                  setState(() {
                    _connector = selected ? 0 : null;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Appwrite'),
                selected: _connector == 1,
                onSelected: (bool selected) {
                  setState(() {
                    _connector = selected ? 1 : null;
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
                        _connectionUri = value;
                      });
                    },
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'SQLite3 Filename',
                      hintText: 'flutter_filemaker.db',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _connector == 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Column(
                children: [
                  TextField(
                    onChanged: (String value) {
                      setState(() {
                        _connectionUri = value;
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
                        _appId = value;
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
