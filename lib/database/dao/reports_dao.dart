import 'package:drift/drift.dart';
import 'package:memo_app/database/database.dart';
import 'package:memo_app/database/tables.dart';

part 'reports_dao.g.dart';

// the _ReportsDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <AppDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [Reports])
class ReportsDao extends DatabaseAccessor<AppDatabase> with _$ReportsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ReportsDao(AppDatabase db) : super(db);

  // CREATE
  // Future<Report> create()
  // READ
  // UPDATE
  // DELETE
}
