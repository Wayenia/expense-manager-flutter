import 'package:expense_manager/providers/expense_provider.dart';
import 'package:expense_manager/widgets/add_tag_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagManagementScreen extends StatefulWidget {
  const TagManagementScreen({super.key});

  @override
  State<TagManagementScreen> createState() => _TagManagementScreenState();
}

class _TagManagementScreenState extends State<TagManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage tags')),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.tags.length,
            itemBuilder: (context, index) {
              final tag = provider.tags[index];
              return ListTile(
                title: Text(tag.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Navigator.pop(context);
                    provider.removeTag(tag.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
       onPressed: () {
            showDialog(
              context: context, 
              builder: (context) => AddTagDialog(
                onAdd: (newTag) {
                  Provider.of<ExpenseProvider>(context, listen: false).addTag(newTag);
                  Navigator.pop(context);
                } ,
                ),
              );
          },
          tooltip: 'Add new Tag',
          child: Icon(Icons.add),
      ),
    );
  }

  // void _showAddTagDialog() {
  //   final TextEditingController nameController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Add tag'),
  //         content: TextFormField(
  //           controller: nameController,
  //           decoration: InputDecoration(labelText: 'Tag Name'),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               final tag = Tag(
  //                 id: DateTime.now().millisecondsSinceEpoch.toString(),
  //                 name: nameController.text,
  //               );
  //               Provider.of<ExpenseProvider>(
  //                 context,
  //                 listen: false,
  //               ).addTag(tag);
  //             },
  //             child: Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
