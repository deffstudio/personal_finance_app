import '../entities/transaction_entity.dart';
import '../entities/category.dart';

abstract class TransactionRepository {
  // Stream of data for reactive UI
  Stream<List<TransactionEntity>> getTransactions();

  // CRUD
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(String transactionId);

  // Categories
  Stream<List<Category>> getCategories();
  Future<void> addCategory(Category category);
}
