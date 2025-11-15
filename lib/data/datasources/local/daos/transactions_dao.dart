import 'package:drift/drift.dart';
import '../app_database.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: [Transactions, Categories])
class TransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionsDaoMixin {
  // The constructor connects this DAO to the main Database
  TransactionsDao(AppDatabase db) : super(db);

  // ---- TRANSACTION OPERATIONS ----

  // Get all transactions (Reactive Stream for UI)
  Stream<List<Transaction>> watchAllTransactions() {
    return (select(transactions)
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  // Insert a transaction
  Future<int> insertTransaction(TransactionsCompanion entry) {
    return into(transactions).insert(entry);
  }

  // Delete a transaction by ID
  Future<int> deleteTransactionById(String id) {
    return (delete(transactions)..where((t) => t.id.equals(id))).go();
  }

  // ---- CATEGORY OPERATIONS ----

  // Get all categories
  Stream<List<Category>> watchAllCategories() {
    return select(categories).watch();
  }

  // Insert a category
  Future<int> insertCategory(CategoriesCompanion entry) {
    return into(categories).insert(entry);
  }
}
