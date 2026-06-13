import 'package:collection/collection.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/providers/expense_provider.dart';
import 'package:expense_manager/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        backgroundColor: Colors.deepPurple[800],
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: [Text('By Date'), Text('By Category')],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.category, color: Colors.deepPurple),
              title: Text('Manage Categories'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/manage_categories');
              },
            ),
            ListTile(
              leading: Icon(Icons.tag, color: Colors.deepPurple),
              title: Text('Manage Tags'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/manage_tags');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildExpensesByDate(context),
          buildExpensesByCategory(context),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddExpenseScreen()),
        ),
        tooltip: 'Add Expense',
        child: Icon(Icons.add, color: Colors.white),
      ),

      // Consumer<ExpenseProvider>(
      //   builder: (context, provider, child) {
      //     final expenses = provider.expenses;
      //     return ListView.builder(
      //       itemCount: expenses.length,
      //       itemBuilder: (context, index) {
      //         final expense = provider.expenses[index];
      //         return ListTile(
      //           title: Text('${expense.payee} - \$${expense.amount}'),
      //           subtitle: Text(
      //             'Category: ${expense.categoryId} - Date: ${expense.date.toIso8601String()}',
      //           ),
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => EditExpenseScreen(expense: expense),
      //               ),
      //             );
      //           },
      //         );
      //       },
      //     );
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => EditExpenseScreen()),
      //     );
      //   },
      //   tooltip: 'Add Expense',
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget buildExpensesByDate(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        if (provider.expenses.isEmpty) {
          return Center(
            child: Text(
              'Click + to record expense',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          );
        }
        return ListView.builder(
          itemCount: provider.expenses.length,
          itemBuilder: (context, index) {
            final expense = provider.expenses[index];
            String formattedDate = DateFormat(
              'MMM dd, yyyy',
            ).format(expense.date);
            return Dismissible(
              key: Key(expense.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                provider.removeExpense(expense.id);
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                color: Colors.purple[50],
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: ListTile(
                  title: Text(
                    "${expense.payee} - \$${expense.amount.toStringAsFixed(2)}",
                  ),
                  subtitle: Text(
                    "$formattedDate - Category: ${getCategoryNameById(context, expense.categoryId)}",
                  ),
                  isThreeLine: true,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildExpensesByCategory(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        if (provider.expenses.isEmpty) {
          return Center(
            child: Text(
              "Click the + button to record expenses.",
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          );
        }

        var grouped = groupBy(provider.expenses, (Expense e) => e.categoryId);

        return ListView(
          children: grouped.entries.map((entry) {
            String categoryName = getCategoryNameById(context, entry.key);
            double total = entry.value.fold(
              0.0,
              (double prev, Expense ex) => (prev + ex.amount),
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "$categoryName - Total: \$${total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: entry.value.length,
                  itemBuilder: (context, index) {
                    Expense expense = entry.value[index];
                    return ListTile(
                      leading: Icon(
                        Icons.monetization_on,
                        color: Colors.deepPurple,
                      ),
                      title: Text(
                        "${expense.payee} - \$${expense.amount.toStringAsFixed(2)}",
                      ),
                      subtitle: Text(
                        DateFormat('MMM dd, yyyy').format(expense.date),
                      ),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  String getCategoryNameById(BuildContext context, String categoryId) {
    var category = Provider.of<ExpenseProvider>(
      context,
      listen: false,
    ).categories.firstWhere((cat) => cat.id == categoryId);
    return category.name;
  }
}
