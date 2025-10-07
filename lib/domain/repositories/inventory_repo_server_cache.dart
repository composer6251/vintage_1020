import 'package:cloud_firestore/cloud_firestore.dart';

///
///  Reading data (Always to Local Cache First, Then Sync to Cloud)
///

final firestore = FirebaseFirestore.instance;

// Listen for all tasks (real-time updates)
Stream<List<Map<String, dynamic>>> getInventoryItemStream() {
  print('retrieving inventory');

  // var test = firestore
  //     .collection('itemInventory')
  //     .snapshots()
  //     .map(
  //       (snapshot) =>
  //           snapshot.docs.asMap((doc) => {'id': doc.id, ...doc.data()}),
  //     )
  //     .toList();

  var test2 = firestore
      .collection('itemInventory')
      .snapshots()
      .map((snapshot) => snapshot.docs.toList());

  // return test2;

  return firestore
      .collection('itemInventory')
      .snapshots() // This is the real-time listener
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList(),
      );
}

Stream<List<Map<String, dynamic>>> getInventoryItemStreamByParam(
  String paramName,
  String paramValue,
) {
  return firestore
      .collection('itemInventory')
      .where(paramName, isEqualTo: paramValue)
      .orderBy('itemId', descending: true)
      .snapshots() // This is the real-time listener
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList(),
      );
}

// Listen for all tasks (real-time updates)
Stream<List<Map<String, dynamic>>> getUsersStream() {
  return firestore
      .collection('inventoryItem')
      .orderBy('username', descending: true)
      .snapshots() // This is the real-time listener
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList(),
      );
}

// Example in a Flutter Widget:
/*
StreamBuilder<List<Map<String, dynamic>>>(
  stream: getTasksStream(),
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
            onChanged: (value) {
              markTaskCompleted(task['id']);
            },
          ),
        );
      },
    );
  },
)
*/
