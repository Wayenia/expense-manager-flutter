import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTagDialog extends StatefulWidget {
  final Function(Tag) onAdd;

  const AddTagDialog({super.key, required this.onAdd});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Tage'),
      content: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(labelText: 'Tag name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),

        TextButton(
          onPressed: () {
            final newTag = Tag(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: _nameController.text,
            );
            if (newTag != null) {
              widget.onAdd(newTag);
              Provider.of<ExpenseProvider>(
                context,
                listen: false,
              ).addTag(newTag);
            }
            _nameController.clear();
            Navigator.of(context).pop();
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
