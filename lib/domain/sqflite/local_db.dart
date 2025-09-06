

// import 'package:path/path.dart';
// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:vintage_1020/data/model/inventory_item.dart';


// class LocalDatabase {

//   // Open the database and store the reference.
//   void createDatabase() async { final database = (
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'vintage_1020.db'),
//     // When the database is first created, create a table to store dogs.
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );
//   }
//   // Define a function that inserts dogs into the database
//   Future<void> addInventoryItem(InventoryItem item) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the Dog into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same dog is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'inventory',
//       item,
//       // conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }


//   Future printAllRowsInTable() async {
//     final db = await albumTestDatabaseInstance.database;
//     // show the results: print all rows in the db
//     print(await db.query(tableAlbumTest));
//   }
// }
