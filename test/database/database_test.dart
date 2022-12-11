import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memo_app/database/database.dart';
// the file defined above, you can test any drift database of course

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });
  tearDown(() async {
    await database.close();
  });

  group('database connection', () {
    test('exist tables', () {
      expect(database.allTables.length, greaterThan(0));
    });
  });

  group('database dao', () {
    test('todos dao', () {
      expect(database.todosDao, isNotNull);
    });
  });
}
