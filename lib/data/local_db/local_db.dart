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

final String dbName = 'vintage_1020.db';
final Uuid uuid = Uuid();
final String? userEmail = FirebaseAuth.instance.currentUser?.email;

// TABLE CREATION SQL
final String buildCreateUserTableSql =
    'CREATE TABLE IF NOT EXISTS user(id TEXT PRIMARY KEY, email TEXT, boothName)';
final String buildCreateInventoryTableSql =
    'CREATE TABLE IF NOT EXISTS inventory_item(id TEXT PRIMARY KEY, email TEXT, primaryImageUrl TEXT, itemDescription TEXT, itemImageUrls TEXT, itemCategory TEXT, itemPurchasePrice REAL, itemListingPrice REAL, itemSoldPrice REAL, itemPurchaseDate TEXT, itemListingDate TEXT, itemSoldDate TEXT, itemHeight REAL, itemWidth REAL, itemDepth REAL, itemDeleteDate TEXT, isCurrentBoothItem REAL)';
final String buildCreateBoothTableSql =
    'CREATE TABLE IF NOT EXISTS my_booth(id TEXT PRIMARY KEY, email TEXT, boothName TEXT, boothImages TEXT, boothDeleteDate REAL)';

// TABLE UPDATES
final String addItemDeleteDateToItemInventorySql =
    'ALTER TABLE $inventoryItemTable ADD COLUMN $deleteDateColumnName';
final String addIsCurrentBoothItemToItemInventorySql =
    'ALTER TABLE $inventoryItemTable ADD COLUMN $isCurrentBoothItem';

// TABLE AND COLUMN NAMES
final String userTable = 'user';
final String inventoryItemTable = 'inventory_item';
final String deleteDateColumnName = 'deleteDate TEXT';
final String isCurrentBoothItem = 'isCurrentBoothItem REAL';

// VERSIONS
final int db_version_two = 2;

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, dbName),
    version: 1,
    onCreate: (db, version) {
      print('Creating inventory table if it does not exist');
      db.execute(buildCreateInventoryTableSql);
      db.execute(buildCreateBoothTableSql);
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      await db.execute(addItemDeleteDateToItemInventorySql);
      await db.execute(addIsCurrentBoothItemToItemInventorySql);
    },
  );
  return db;
}

class LocalDb {
  Future<void> _createUserAndInventoryTables(Database db) async {
    print('\nCreating user and inventory tables\n');
    // TODO check if table exists
    var userTbl = await db.query(
      'sqlite_master',
      where: 'name = ?',
      whereArgs: [userTable],
    );
    var invTbl = await db.query(
      'sqlite_master',
      where: 'name = ?',
      whereArgs: [inventoryItemTable],
    );

    if (userTbl.isEmpty) {
      await db.execute(buildCreateUserTableSql);
    }
    if (invTbl.isEmpty) {
      await db.execute(buildCreateInventoryTableSql);
    }
    var tables = await db.query(
      'sqlite_master',
      where: 'name = ?',
      whereArgs: [userTable, inventoryItemTable],
    );
    print('tables created or already existed ${tables.length}');
  }

  void insertIntoInventoryItem(InventoryItemLocal item) async {
    final db = await _getDatabase();

    db.insert(inventoryItemTable, item.toMapForLocalDB(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<InventoryItemLocal>> fetchUserInventoryFromDb() async {
    final db = await _getDatabase();

    List<Set<InventoryItemLocal>> inventory = [];
    try {
      final data = await db.query(
        inventoryItemTable,
        where: 'email = ? AND itemDeleteDate IS NULL',
        
        whereArgs: [
          userEmail,
        ]
      );
      inventory = data.map((row) => {InventoryItemLocal.fromLocalDB(row)}).toList();
    } catch(ex) {
      print('Exception caught in fetchUserInventoryFromDb: $ex');
    }

    // Create List from the List<Set> returned
    List<InventoryItemLocal> flattenedInventory = [];

    for (Set<InventoryItemLocal> set in inventory) {
      flattenedInventory.addAll(set);
    }

    return flattenedInventory;
  }


  Future<int> addInventoryItemToCurrentBooth(String id) async {
    final db = await _getDatabase();

    print('addInventoryItemToCurrentBooth: $id');

    final int updatedId = await db.update(inventoryItemTable, {
      'itemListingDate': DateTime.now().toIso8601String(),
      'isCurrentBoothItem': 1,
    }, where: 'id = "$id"');

    print('Added item to booth: $updatedId');
    return updatedId;
}
// TODO: CREATE METHOD TO UPDATE BY ID.
  Future<int> updateInventoryItem(InventoryItemLocal itemToUpdate) async {
    final db = await _getDatabase();
    itemToUpdate.userEmail = userEmail;
    final int updatedId = await db.update(
      inventoryItemTable, 
      itemToUpdate.toMapForLocalDB(), 
      conflictAlgorithm: ConflictAlgorithm.replace, 
      where: 'id = "${itemToUpdate.id}"');

    print('Added item to booth: $updatedId');
    return updatedId;
}


  Future<int> hardDeleteInventoryItem(String id) async {
    final db = await _getDatabase();

    final int deletedId = await db.delete(
      inventoryItemTable,
      where: 'id = "$id"',
    );

    return deletedId;
  }

  Future<int> softDeleteInventoryItem(String id) async {
    final db = await _getDatabase();

    final int deletedId = await db.update(inventoryItemTable, {
      'itemDeleteDate': DateTime.now().toIso8601String(),
    }, where: 'id = "$id"');

    return deletedId;
  }

  // UTIL AND TESTING QUERIES
  Future printAllRowsInTable() async {
    final db = await _getDatabase();
    // show the results: print all rows in the db
    print(await db.query(inventoryItemTable));
  }

  void dropInventoryItemTable() async {
  final db = await _getDatabase();

  db.execute('DROP TABLE $inventoryItemTable');
}
  Future<int> deleteUserInventory() async {
    print('\n\n\n DELETING USER INVENTORY FOR EMAIL: $userEmail');

    final db = await _getDatabase();
    final int deletedId = await db.delete(
      inventoryItemTable,
      where: 'email = "$userEmail"',
    );

    return deletedId;
  }
}
