import 'package:expense_manager/providers/expense_provider.dart';
import 'package:expense_manager/widgets/add_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Categories"),
        backgroundColor: Colors.deepPurple, 
        foregroundColor: Colors.white,
      ),
      body: Consumer<ExpenseProvider>(builder: (context, provider, child) {
      return ListView.builder(
        itemCount: provider.categories.length,
        itemBuilder: (context, index) {
          final category = provider.categories[index];
          return ListTile(
            title: Text(category.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                provider.removeCategory(category.id);
              }, 
              ),
          );
        },
      );
    }),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
            showDialog(
              context: context, 
              builder: (context) => AddCategoryDialog(
                onAdd: (newCategory) {
                  Provider.of<ExpenseProvider>(context, listen: false).addCategory(newCategory);
                  Navigator.pop(context);
                } ,
                ),
              );
          },
          tooltip: 'Add new category',
          child: Icon(Icons.add)
      ),
    );
  }
  
  // void _showAddCategoryDialog(BuildContext context) {
  //   final TextEditingController categoryNameController = TextEditingController();
  //   showDialog(context: context, 
  //   builder: (context){
  //     return AlertDialog(
  //       title: Text('Add category'),
  //       content: TextFormField(
  //         controller: categoryNameController,
  //         decoration: InputDecoration(labelText: 'Category Name'),
  //       ),
  //       actions: [
  //         TextButton(onPressed: () {
  //           Navigator.pop(context);
  //         }, 
  //         child: Text('Cancel')
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //           showDialog(
  //             context: context, 
  //             builder: (context) => AddCategoryDialog(
  //               onAdd: (newCategory) {
  //                 Provider.of<ExpenseProvider>(context, listen: false).addCategory(newCategory);
  //                 Navigator.pop(context);
  //               } ,
  //               ),
  //             );
  //         },,
  //         child: Icon(Icons.add)
  //         ),
  //       ],
  //     );
  //   });
  // }
}
