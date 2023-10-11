import 'package:appwrite/appwrite.dart';

void connect(url, projectId) async {
  Client client = Client();
  client.setEndpoint(url).setProject(projectId).setSelfSigned(status: true);
}
