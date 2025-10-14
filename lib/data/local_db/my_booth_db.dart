import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/repositories/firestore/firestore_repository.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

import 'dart:developer' as dev;

import 'package:vintage_1020/domain/my_booth/my_booth.dart';

final String dbName = 'vintage_1020.db';
final Uuid uuid = Uuid();
final String? userEmail = FirebaseAuth.instance.currentUser?.email;
// CHECK IF USER HAS SIGNED IN BEFORE
final DateTime? test = FirebaseAuth.instance.currentUser?.metadata.lastSignInTime;

// Storing id and email for viewing past booths
final String buildCreateBoothTableSql =
    'CREATE TABLE IF NOT EXISTS my_booth(id TEXT PRIMARY KEY, email TEXT, boothName TEXT, boothImages TEXT, boothDeleteDate REAL)';

final String myBoothTable = 'my_booth';

final int db_version_two = 2;

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, dbName),
    version: 1,
    onCreate: (db, version) {
      print('Creating inventory table if it does not exist');
      db.execute(buildCreateBoothTableSql);
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      // await db.execute(addItemDeleteDateToItemInventorySql);
      // await db.execute(addIsCurrentBoothItemToItemInventorySql);
    },
  );
  return db;
}

// Check firebaseAuth to see if user has logged in before
//If user created account, then local sqflite DB should be created

class LocalDb {

  void insertIntoMyBooth(MyBooth booth) async {
    final db = await _getDatabase();

    db.insert(myBoothTable, booth.toMapForLocalDB());
  }

  Future<List<MyBooth>> fetchCurrentBoothFromDb() async {
    final db = await _getDatabase();

    List<Set<MyBooth>> booths = [];
    try {
      final data = await db.query(
        myBoothTable,
        where: 'email = ? AND boothDeleteDate IS NULL',
        
        whereArgs: [
          userEmail,
        ]
      );
      booths = data.map((row) => {MyBooth.fromLocalDB(row)}).toList();
    } catch(ex) {
      print('Exception caught in fetchUserInventoryFromDb: $ex');
    }

    // Create List from the List<Set> returned
    List<MyBooth> flattenedBooths = [];

    for (Set<MyBooth> set in booths) {
      flattenedBooths.addAll(set);
    }

    return flattenedBooths;
  }

  Future<int> softDeleteInventoryItem(String id) async {
    final db = await _getDatabase();

    final int deletedId = await db.update(myBoothTable, {
      'boothDeleteDate': DateTime.now().toIso8601String(),
    }, where: 'id = "$id"');

    return deletedId;
  }

  // Future<int> addInventoryItemToCurrentBooth(String id) async {
  //   final db = await _getDatabase();

  //   final int updatedId = await db.update(myBoothTable, {
  //     'itemListingDate': DateTime.now().toIso8601String(),
  //     'isCurrentBoothItem': 1,
  //   }, where: 'id = "$id"');

  //   return updatedId;
  // }

  Future printAllRowsInTable() async {
    final db = await _getDatabase();
    // show the results: print all rows in the db
    print(await db.query(myBoothTable));
  }
}
