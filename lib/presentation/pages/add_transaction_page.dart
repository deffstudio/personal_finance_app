import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:personal_finance_app/domain/entities/transaction_entity.dart';
import 'package:personal_finance_app/presentation/bloc/transaction_list/transaction_list_bloc.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isExpense = true;
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);

      final newTransaction = TransactionEntity(
        id: Uuid().v4(), // Generate a unique ID
        description: _descController.text,
        amount: amount,
        isExpense: _isExpense,
        date: _selectedDate,
        category: null, // We will handle categories in Module 6
      );

      // Send Event to Bloc
      context.read<TransactionListBloc>().add(AddTransaction(newTransaction));

      // Go back to Dashboard
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Toggle Type
              Row(
                children: [
                  const Text("Income"),
                  Switch(
                    value: _isExpense,
                    onChanged: (val) => setState(() => _isExpense = val),
                    activeColor: Colors.red,
                    inactiveThumbColor: Colors.green,
                  ),
                  const Text("Expense"),
                ],
              ),
              // Description
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value!.isEmpty ? "Enter a description" : null,
              ),
              // Amount
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter an amount';
                  if (double.tryParse(value) == null)
                    return 'Plese enter a valid number';
                  return null;
                },
              ),
              // Date Picker (Simplified)
              ListTile(
                title: Text(
                    "Date: ${_selectedDate.toLocal().toString().split(' ')[0]}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => _selectedDate = picked);
                },
              ),

              const Spacer(),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitData,
                  child: const Text("Save Transaction"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
