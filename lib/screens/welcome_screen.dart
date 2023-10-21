import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filemaker_desktop/connectors/sqlite_connector.dart';
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
  SqliteConnector sqliteConnector = SqliteConnector();
  late var connectionDatabase;
  int _connector = 0;
  String _connectionName = "";
  String _databaseName = "";
  String _connectionUri = "";
  String _appId = "";
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Future<void> _setDBConnectorOptions() async {
    switch (_connector) {
      case 0:
        DBConnection connection = DBConnection(
            connection_name: _connectionName,
            type: _connector,
            database_name: _databaseName,
            connection_uri: _connectionUri,
            app_id: _appId);

        insertConnection(connection);
        break;
      case 1:
        break;
    }
  }

  bool fieldsComplete() {
    switch (_connector) {
      case 0:
        return _connectionName.isNotEmpty && _connectionUri.isNotEmpty;
      case 1:
        return _connectionName.isNotEmpty &&
            _connectionUri.isNotEmpty &&
            _appId.isNotEmpty;
      case 2:
        break;
    }
    return false;
  }

  void setupDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    connectionDatabase = sqliteConnector.connect();
  }

  Future<dynamic> getConnections() {
    return _memoizer.runOnce(() async {
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
    });
  }

  Future<void> insertConnection(DBConnection connection) async {
    sqliteConnector.insert(connectionDatabase, 'connections', connection);
  }

  @override
  void initState() {
    setupDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<dynamic>(
              future: getConnections(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done &&
                    snapshot.data!.isNotEmpty) {
                  return SizedBox(
                    height: 300,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6, // number of items in each row
                          mainAxisSpacing: 8.0, // spacing between rows
                          crossAxisSpacing: 8.0, // spacing between columns
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.blue,
                            height: 50,
                            width: 50,
                            child: Text(
                                snapshot.data![index].connection_name.length > 0
                                    ? snapshot.data![index].connection_name
                                    : snapshot.data![index].connection_uri),
                          );
                        }),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return const SizedBox();
                }
              }),
          Wrap(
            spacing: 5.0,
            children: [
              ChoiceChip(
                label: const Text('Local Sqlite3'),
                selected: _connector == 0,
                onSelected: (bool selected) {
                  setState(() {
                    _connector = selected ? 0 : 10;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Appwrite'),
                selected: _connector == 1,
                onSelected: (bool selected) {
                  setState(() {
                    _connector = selected ? 1 : 10;
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
                        _connectionName = value;
                      });
                    },
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Connection Name',
                      hintText: 'Connection 1',
                    ),
                  ),
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
                        _connectionName = value;
                      });
                    },
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Connection Name',
                      hintText: 'Connection 1',
                    ),
                  ),
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
