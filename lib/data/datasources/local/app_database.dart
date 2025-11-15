import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'daos/transactions_dao.dart';

part 'app_database.g.dart';

class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get description => text().nullable()();
  RealColumn get amount => real()(); // Storing money as Double for MVP
  DateTimeColumn get date => dateTime()();
  // We will store "income" or "expense" as an integer (0 or 1) or string
  // Simple approach: boolean
  BoolColumn get isExpense => boolean().withDefault(const Constant(true))();

  // Foreign Key to Categories
  TextColumn get categoryId => text().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get icon => text()(); // e.g 'fastfood' or hex code
  TextColumn get color => text()(); // e.g '#FF5733'
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Transactions, Categories], daos: [TransactionsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // You can add DAOs or query methods here
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Put the database file, called "db.sqlite" here, into documents folder
    // for your app
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
