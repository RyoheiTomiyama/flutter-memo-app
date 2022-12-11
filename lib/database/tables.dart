import 'package:drift/drift.dart';
import 'package:memo_app/domain/report/enum_report.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}

// This will make drift generate a class called "Category" to represent a row in
// this table. By default, "Categorie" would have been used because it only
//strips away the trailing "s" in the table name.
// @DataClassName('Category')
class Reports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get videoId => text()();
}

class ReportTricks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stance => intEnum<ReportStance>().nullable()();
  IntColumn get direction => intEnum<ReportDirection>().nullable()();
  IntColumn get spin => intEnum<ReportSpin>().nullable()();
  IntColumn get reportId => integer().nullable()();
}

class ReportResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get approachScore => integer().nullable()();
  IntColumn get takeoffScore => integer().nullable()();
  IntColumn get peakScore => integer().nullable()();
  IntColumn get landingScore => integer().nullable()();
  IntColumn get reportId => integer().nullable()();
}
