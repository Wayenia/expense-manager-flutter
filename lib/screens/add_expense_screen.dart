import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/providers/expense_provider.dart';
import 'package:expense_manager/widgets/add_category_dialog.dart';
import 'package:expense_manager/widgets/add_tag_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? initialExpense;

  const AddExpenseScreen({super.key, this.initialExpense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  late TextEditingController _amountController = TextEditingController();
  late TextEditingController _payeeController = TextEditingController();
  late TextEditingController _noteController = TextEditingController();

  String? _selectedCategoryId;
  String? _selectedTagId;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.initialExpense?.amount.toString() ?? '',
    );
    _noteController = TextEditingController(
      text: widget.initialExpense?.note.toString() ?? '',
    );
    _payeeController = TextEditingController(
      text: widget.initialExpense?.payee.toString() ?? '',
    );
    _selectedDate = widget.initialExpense?.date ?? DateTime.now();
    _selectedCategoryId = widget.initialExpense?.categoryId;
    _selectedTagId = widget.initialExpense?.tag;
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialExpense == null ? 'Add Expense' : 'Edit Expense',
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField(
              _amountController,
              'Amount',
              TextInputType.numberWithOptions(decimal: true),
            ),
            buildTextField(_noteController, 'Note', TextInputType.text),
            buildTextField(_payeeController, 'Payee', TextInputType.text),
            // buildCategoryDropdown(expenseProvider),
            // buildTagDropdown(expenseProvider),
            buildDateField(_selectedDate),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: buildCategoryDropdown(expenseProvider),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: buildTagDropdown(expenseProvider),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: _saveExpense, 
          child: Text('Save Expense'),
          ),
      ),
    );
  }

  void _saveExpense() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill required fields')));
      return;
    }

    final expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: double.parse(_amountController.text),
      categoryId: _selectedCategoryId!,
      date: _selectedDate,
      note: _noteController.text,
      payee: _payeeController.text,
      tag: _selectedTagId!,
    );
    Provider.of<ExpenseProvider>(
      context,
      listen: false,
    ).addOrUpdateExpense(expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _payeeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  /// helpers
  Widget buildTextField(
    TextEditingController controller,
    String label,
    TextInputType type,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: type,
      ),
    );
  }

  /// date picker
  Widget buildDateField(DateTime selectedDate) {
    return ListTile(
      title: Text("Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
      trailing: Icon(Icons.calendar_today),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (picked != null && picked != selectedDate) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
    );
  }

  /// category dropdown
  Widget buildCategoryDropdown(ExpenseProvider provider) {
    return DropdownButtonFormField(
      items:
          provider.categories.map<DropdownMenuItem<String>>((category) {
            return DropdownMenuItem<String>(
              value: category.id,
              child: Text(category.name),
            );
          }).toList()..add(
            DropdownMenuItem<String>(
              value: "New",
              child: Text('Add new category'),
            ),
          ),
      onChanged: (newValue) {
        if (newValue == 'New') {
          showDialog(
            context: context,
            builder: (context) => AddCategoryDialog(
              onAdd: (newCategory) {
                setState(() {
                  _selectedCategoryId = newCategory.id;
                  provider.addCategory(newCategory);
                });
              },
            ),
          );
        } else {
          setState(() {
            _selectedCategoryId = newValue;
          });
        }
      },
      decoration: InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
      ),
    );
  }

  /// tag  dropdown
  Widget buildTagDropdown(ExpenseProvider provider) {
    return DropdownButtonFormField<String>(
      items:
          provider.tags.map<DropdownMenuItem<String>>((tag) {
              return DropdownMenuItem<String>(
                value: tag.id,
                child: Text(tag.name),
              );
            }).toList()
            ..add(DropdownMenuItem(value: 'New', child: Text('Add New Tag'))),
      decoration: InputDecoration(
        labelText: 'Add new tag',
        border: OutlineInputBorder(),
      ),
      onChanged: (newValue) {
        if (newValue == 'New') {
          showDialog(
            context: context,
            builder: (context) => AddTagDialog(
              onAdd: (newTag) {
                provider.addTag(newTag);
                setState(() {
                  _selectedTagId = newTag.id;
                });
              },
            ),
          );
        } else {
          setState(() {
            _selectedTagId = newValue;
          });
        }
      },
    );
  }
}
