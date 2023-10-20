class DBConnection {
  final int id;
  final String connection_name;
  final int type; // 0: SQLite3 1: Appwrite 2: Firebase
  final String database_name;
  final String connection_uri;
  String app_id = '';

  DBConnection({
    required this.id,
    required this.connection_name,
    required this.type,
    required this.database_name,
    required this.connection_uri,
    required this.app_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'connection_name': connection_name,
      'type': type,
      'database_name': database_name,
      'connection_uri': connection_uri,
      'app_id': app_id
    };
  }

  @override
  String toString() {
    return 'DBConnection{id: $id, connection_name: $connection_name, type: $type, database_name: $database_name, connection_uri: $connection_uri, app_id: $app_id}';
  }
}
