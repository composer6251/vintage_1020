import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';

final String dbName = 'vintage_1020.db';
final Uuid uuid = Uuid();
final String? userEmail = FirebaseAuth.instance.currentUser?.email;

final String buildCreateUserTableSql =
    'CREATE TABLE user(id TEXT PRIMARY KEY, email TEXT, inventory_id)';
final String buildCreateInventoryTableSql =
    'CREATE TABLE inventory_item(id TEXT PRIMARY KEY, email TEXT, primaryImageUrl TEXT, itemDescription TEXT, itemImageUrls TEXT, itemCategory TEXT, itemPurchasePrice REAL, itemListingPrice REAL, itemSoldPrice REAL, itemPurchaseDate TEXT, itemListingDate TEXT, itemSoldDate TEXT, itemDimensions TEXT)';

final String userTable = 'user';
final String inventoryItemTable = 'inventory_item';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, dbName),
    onCreate: (db, version) {
      return db.execute(buildCreateInventoryTableSql);
    },
    version: 1,
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

  void insertIntoInventoryItemUrlList(InventoryItemLocal item) async {
    final db = await _getDatabase();

    db.insert(inventoryItemTable, {
      'id': item.id,
      'email': userEmail,
      'primaryImageUrl': item.primaryImageUrl,
      'itemDescription': item.itemDescription,
      'itemImageUrls': json.encode(
        item.itemImageUrls,
      ), // sqflite does have a List type, so encode to String
      'itemCategory': item.itemCategory,
      'itemPurchasePrice': item.itemPurchasePrice,
      'itemListingPrice': item.itemListingPrice,
      'itemSoldPrice': item.itemSoldPrice,
      'itemPurchaseDate': item.itemPurchaseDate?.toIso8601String(),
      'itemListingDate': item.itemListingDate?.toIso8601String(),
      'itemSoldDate': item.itemSoldDate?.toIso8601String(),
      'itemDimensions': item.itemDimensions,
    });
  }

  void insertIntoInventoryItem(InventoryItemLocal item) async {
    final db = await _getDatabase();

    db.insert(inventoryItemTable, item.toMapForLocalDB());

    // db.insert(inventoryItemTable, {
    //   'id': item.id,
    //   'email': userEmail,
    //   'primaryImageUrl': item.primaryImageUrl,
    //   'itemDescription': item.itemDescription,
    //   'itemImageUrls': json.encode(
    //     item.itemImageUrls,
    //   ), // sqflite does have a List type, so encode to String
    //   'itemCategory': item.itemCategory,
    //   'itemPurchasePrice': item.itemPurchasePrice,
    //   'itemListingPrice': item.itemListingPrice,
    //   'itemSoldPrice': item.itemSoldPrice,
    //   'itemPurchaseDate': item.itemPurchaseDate?.toIso8601String(),
    //   'itemListingDate': item.itemListingDate?.toIso8601String(),
    //   'itemSoldDate': item.itemSoldDate?.toIso8601String(),
    //   'itemDimensions': item.itemDimensions,
    // });
  }

  Future<List<InventoryItemLocal>> getUserInventoryLocal() async {
    printAllRowsInTable();
    final db = await _getDatabase();
    final data = await db.query(
      inventoryItemTable,
      where: 'email = "$userEmail"',
    );
    List<Set<InventoryItemLocal>> inventory = data
        .map((row) => {InventoryItemLocal.fromLocalDB(row)})
        .toList();

    // Create List from the List<Set> returned
    List<InventoryItemLocal> flattenedInventory = [];

    for (Set<InventoryItemLocal> set in inventory) {
      flattenedInventory.addAll(set);
    }

    return flattenedInventory;
  }

  Future<void> deleteInventoryItem(String id) async {
    final db = await _getDatabase();
    await db.delete(inventoryItemTable, where: 'id = ');
  }

  Future<int> deleteUserInventory() async {
    print('\n\n\n DELETING USER INVENTORY FOR EMAIL: $userEmail');

    final db = await _getDatabase();
    final int deletedId = await db.delete(
      inventoryItemTable,
      where: 'email = "$userEmail"',
    );
    print('\n\n\n DELETED USER INVENTORY: $deletedId');

    return deletedId;

  }

  Future printAllRowsInTable() async {
    final db = await _getDatabase();
    // show the results: print all rows in the db
    print('\n\n\nPRINTING RESULTS FROM ALL ITEMS IN INVENTORY ITEM TABLE');
    print(await db.query(inventoryItemTable));
  }
}
