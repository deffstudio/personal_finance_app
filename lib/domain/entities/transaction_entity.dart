import 'package:equatable/equatable.dart';
import 'category.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String? description;
  final double amount;
  final DateTime date;
  final bool isExpense;
  final Category? category; // We link the full object here for easier UI

  const TransactionEntity({
    required this.id,
    this.description,
    required this.amount,
    required this.date,
    required this.isExpense,
    this.category,
  });

  @override
  List<Object?> get props =>
      [id, description, amount, date, isExpense, category];
}
