import 'package:drift/drift.dart'; // For Value/Companion
import '../../domain/entities/category.dart' as domain;
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../data/datasources/local/app_database.dart'; // Drift generated classes

class TransactionRepositoryImpl implements TransactionRepository {
  final AppDatabase _db;

  TransactionRepositoryImpl(this._db);

  // --- TRANSACTIONS ---

  @override
  Stream<List<TransactionEntity>> getTransactions() {
    // 1. Listen to the DAO
    return _db.transactionsDao.watchAllTransactions().map((rows) {
      // 2. Map (Convert) Drift Rows -> Domain Entities
      return rows.map((row) {
        return TransactionEntity(
          id: row.id,
          description: row.description,
          amount: row.amount,
          date: row.date,
          isExpense: row.isExpense,
          // Note: We only have categoryId here from the simple query.
          // For MVP, we leave the full object null or load it  separately.
          // We will improve this with a JOIN query in Module 6.
          category: null,
        );
      }).toList();
    });
  }

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    // 1. Map Domain Entity -> Drift Companion (for inserting)
    final entry = TransactionsCompanion(
      id: Value(transaction.id),
      description: Value(transaction.description),
      amount: Value(transaction.amount),
      date: Value(transaction.date),
      isExpense: Value(transaction.isExpense),
      categoryId: Value(transaction.category?.id ?? 'default'),
    );

    // 2. Call the DAO
    await _db.transactionsDao.insertTransaction(entry);
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    await _db.transactionsDao.deleteTransactionById(transactionId);
  }

  // --- CATEGORIES ---

  @override
  Stream<List<domain.Category>> getCategories() {
    return _db.transactionsDao.watchAllCategories().map((rows) {
      return rows.map((row) {
        return domain.Category(
          id: row.id,
          name: row.name,
          icon: row.icon,
          color: row.color,
          isDefault: row.isDefault,
        );
      }).toList();
    });
  }

  @override
  Future<void> addCategory(domain.Category category) async {
    final entry = CategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      icon: Value(category.icon),
      color: Value(category.color),
      isDefault: Value(category.isDefault),
    );
    await _db.transactionsDao.insertCategory(entry);
  }
}
