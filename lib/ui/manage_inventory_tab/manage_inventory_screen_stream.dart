import 'package:flutter/material.dart';
import 'package:vintage_1020/domain/repositories/inventory_repo_server_cache.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageInventoryScreenStream extends StatelessWidget {
  const ManageInventoryScreenStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> launchWebApp() async {
      // TODO:
      Uri uri = Uri(scheme: 'web', host: 'localhost', port: 60219);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    }

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: getInventoryItemStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (!snapshot.hasData) return CircularProgressIndicator();
        final tasks = snapshot.data!;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              title: Text(task['title']),
              subtitle: Text(task['description']),
              trailing: Checkbox(
                value: task['completed'],
                onChanged: (value) {},
              ),
            );
          },
        );
      },
    );
  }
}
