import 'package:drift/drift.dart';
import 'package:memo_app/database/database.dart';

MigrationStrategy AppMigrationStragegy(AppDatabase db) {
  return MigrationStrategy(
    beforeOpen: (details) async {
      await db.customStatement('PRAGMA foreign_keys = ON');
    },
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {},
  );
}
