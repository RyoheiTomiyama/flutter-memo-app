// To open the database, add these imports to the existing file defining the
// database class. They are used to open the database.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:memo_app/database/migrations/migration_strategy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:memo_app/database/tables.dart';
import 'package:memo_app/domain/report/enum_report.dart';

import 'dao/reports_dao.dart';
import 'dao/todos_dao.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'database.g.dart';

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(
  tables: [Todos, Reports, ReportTricks, ReportResults],
  daos: [TodosDao, ReportsDao],
)
class AppDatabase extends _$AppDatabase {
  final QueryExecutor? e;
  AppDatabase(this.e) : super(e ?? _openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => AppMigrationStragegy(this);
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    // DBの場所調べる
    // print(dbFolder);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
