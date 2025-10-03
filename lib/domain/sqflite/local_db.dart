import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory.dart';
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

class LocalDb {
  Future<Database> _getDatabase() async {
    print('creating DB');
    final dbPath = await sql.getDatabasesPath();

    final db = await sql.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) {
        return db.execute(buildCreateInventoryTableSql);
      }, 
      version: 1);

    // _createUserAndInventoryTables(db);

    return db;
  }

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
      'primaryImageUrl': item.primaryImageUrl,
      'itemDescription': item.itemDescription,
      'itemImageUrls': item.itemImageUrls,
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

    db.insert(inventoryItemTable, {
      'id': item.id,
      'primaryImageUrl': item.primaryImageUrl,
      'itemDescription': item.itemDescription,
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

  Future<List<Set<InventoryItemLocal>>> getUserInventoryLocal() async {
    printAllRowsInTable();
    final db = await _getDatabase();
    final data = await db.query(
      inventoryItemTable,
      where: 'email = "dfennell31@gmail.com"',
    );
    print('Records retrieved from local DB: ${data.length}');
    List<Set<InventoryItemLocal>> inventory = await data
        .map((row) => {InventoryItemLocal.fromJson(row)})
        .toList();
    print(
      'Records from local DB mapped to InventoryItemLocal: ${inventory.length}',
    );

    return inventory;
  }

  Future printAllRowsInTable() async {
    final db = await _getDatabase();
    // show the results: print all rows in the db
    print('\n\n\nPRINTING RESULTS FROM ALL ITEMS IN INVENTORY ITEM TABLE');
    print(await db.query(inventoryItemTable));
    print('\n\n\nPRINTING RESULTS FROM ALL ITEMS IN INVENTORY ITEM TABLE');
    print(await db.query(userTable));
  }
}
