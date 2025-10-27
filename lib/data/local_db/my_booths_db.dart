import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

final String dbName = 'vintage_1020.db';
final Uuid uuid = Uuid();
final String? userEmail = FirebaseAuth.instance.currentUser?.email;

// TABLE CREATION SQL
final String buildCreateBoothTableSql =
    'CREATE TABLE IF NOT EXISTS my_booth(id TEXT PRIMARY KEY, boothName TEXT, email TEXT, boothInventoryIds TEXT, currentBoothImageUrls TEXT, boothDeleteDate TEXT)';
final String buildCreateInventoryTableSql =
    'CREATE TABLE IF NOT EXISTS inventory_item(id TEXT PRIMARY KEY, email TEXT, primaryImageUrl TEXT, itemDescription TEXT, itemImageUrls TEXT, itemCategory TEXT, itemPurchasePrice REAL, itemListingPrice REAL, itemSoldPrice REAL, itemPurchaseDate TEXT, itemListingDate TEXT, itemSoldDate TEXT, itemHeight REAL, itemWidth REAL, itemDepth REAL, itemDeleteDate TEXT, isCurrentBoothItem REAL)';

// TABLE AND COLUMN NAMES
final String inventoryItemTable = 'inventory_item';
final String myBoothTable = 'my_booth';

// VERSIONS
final int db_version_two = 2;

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(path.join(dbPath, dbName), version: 1);

  return db;
}

class MyBoothsDb {
  Future<List<MyBooth>> fetchUserBoothsByEmail() async {
    final db = await _getDatabase();

    print('fetchingBoothsByEmail: $userEmail');

    List<Set<MyBooth>> booths = [];
    try {
      final data = await db.query(
        myBoothTable,
        where: 'email = ? AND boothDeleteDate IS NULL',
        whereArgs: [userEmail],
      );
      booths = data.map((booth) => {MyBooth.fromLocalDB(booth)}).toList();
    } catch (ex) {
      print('Exception caught in fetchingBoothsByEmail: $ex');
    }

    List<MyBooth> flattenedBooths = [];

    for (Set<MyBooth> set in booths) {
      flattenedBooths.addAll(set);
    }

    return flattenedBooths;
  }

  Future<void> addBoothToMyBoothTable(MyBooth booth) async {
    final db = await _getDatabase();
    booth.userEmail = userEmail ?? '';
    if (booth.boothName == null) 'My Booth';
    print(
      'addBoothToMyBoothTable: ${booth.id} with urls ${booth.currentBoothImageUrls?.first}',
    );

    db.insert(
      myBoothTable,
      booth.toMapForLocalDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> createBoothForUser(MyBooth booth) async {
    final db = await _getDatabase();
    // Set Booth Id
    booth.id = uuid.v6();

    try {
      db.insert(
        myBoothTable,
        booth.toMapForLocalDB(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print('error creating booth for user');
    }
  }

    // TODO: CREATE METHOD TO UPDATE BY ID.
  Future<int> updateBooth(MyBooth booth) async {
    final db = await _getDatabase();

    final int updatedId = await db.update(
      myBoothTable,
      booth.toMapForLocalDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'id = "${booth.id}"',
    );

    print('Added item to booth: $updatedId');
    return updatedId;
  }

  Future<void> softDeleteBoothsByUserEmail() async {
    final db = await _getDatabase();

    final int deletedId = await db.update(myBoothTable, {
      'boothDeleteDate': DateTime.now().toIso8601String(),
    }, where: 'email = "$userEmail"');

    print('$deletedId Booths deleted for $userEmail');
  }
}
