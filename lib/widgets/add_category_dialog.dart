import 'package:expense_manager/models/expense_category.dart';
import 'package:expense_manager/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryDialog extends StatefulWidget {
  final Function(ExpenseCategory) onAdd;

  const AddCategoryDialog({super.key, required this.onAdd});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Category'),
      content: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(labelText: 'Category name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),

        TextButton(
          onPressed: () {
            var newCategory = ExpenseCategory(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: _nameController.text,
            );
            if (newCategory != null) {
              widget.onAdd(newCategory);
              Provider.of<ExpenseProvider>(
                context,
                listen: false,
              ).addCategory(newCategory);
              _nameController.clear();
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
