import 'package:drift/drift.dart';
import 'package:memo_app/database/database.dart';
import 'package:memo_app/database/tables.dart';

part 'todos_dao.g.dart';

// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <AppDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TodosDao(AppDatabase db) : super(db);

  Future<List<Todo>> getAllTodos() {
    return select(todos).get();
  }
}
