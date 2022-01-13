import 'dart:io';
import 'package:path/path.dart';
import 'package:sqlite3/sqlite3.dart';

import 'product.dart';

class DB {
  late final Database db;
  DB(String fileName) {
    final path = join(Directory.current.path, 'lib', fileName);
    db = sqlite3.open(path);
    db.execute("PRAGMA foreign_keys = ON");
    migrate();
  }

  void dispose() => db.dispose();

  //_____________ INTERNAL _________________
  ResultSet _select(String sql, [List<Object?> parameters = const []]) {
    return db.select(sql, parameters);
  }

  int _execute(String sql, [List<Object?> parameters = const []]) {
    final stmt = db.prepare(sql);
    stmt.execute(parameters);
    final count = db.getUpdatedRows();
    stmt.dispose();
    return count;
  }

  //_____________ MIGRATIONS ____________________
  Map<int, List<String>> migrations = const {
    0: [
      '''CREATE TABLE "products" ("id" INTEGER NOT NULL UNIQUE, "title" TEXT
           NOT NULL, "description" TEXT NOT NULL, PRIMARY KEY("id"
               AUTOINCREMENT))'''
    ],
  };

  int get version {
    return _select("pragma user_version").first['user_version'];
  }

  set version(int value) {
    _execute("pragma user_version = $value");
  }

  void migrate() {
    var ver = version;
    var migs = migrations[ver];
    while (migs != null) {
      _execute('BEGIN TRANSACTION');
      try {
        for (var m in migs) {
          _execute(m);
        }
        version = ++ver;
        _execute('COMMIT');
        print('Successfully applied ${migs.length} migrations.');
      } catch (e) {
        print('Error applying migrations: $e');
        _execute('ROLLBACK');
      }
      migs = migrations[ver];
    }
  }

  //________________ SEED ___________________________
  void seed() {
    final check = _select("SELECT * FROM products", []);
    if (check.isEmpty) {
      _execute("INSERT INTO products (title, description) VALUES(?, ?)",
          ["Книжная полка", "Лучшая книжная полка на всем континенте"]);
      _execute("INSERT INTO products (title, description) VALUES(?, ?)",
          ["Бокал", "Для кофе, вина и шампанского"]);
      _execute("INSERT INTO products (title, description) VALUES(?, ?)",
          ["Портрет", "Сами знаете кого"]);
    }
  }

  //_________________ PRODUCTS ______________________
  List<Product> products() {
    final result = _select("SELECT * FROM products ORDER BY id");
    List<Product> list = List.from(result.map((row) => Product.fromMap(row)));
    return list;
  }
}
