import 'package:get_it/get_it.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // 1. Register Database (The Vault)
  // LazySingleton = Created only when requested the first time, then kept alive.
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // 2. Register Repository (The Brain)
  // We register the Interface (TransactionRepository), but return the implementation.
  // This means if we ask for TransactionRepository, we get the Impl.
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()),
  );

  // 3. (Future) We will register BloCs here later.
}
