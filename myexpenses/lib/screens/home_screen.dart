import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [
    const Expense(
      id: 'e1',
      title: 'Հաց',
      amount: 500,
      category: Category.food,
    ),
  ];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
@override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  void _addExpense() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.trim().isEmpty || enteredAmount == null || enteredAmount <= 0) {
      return;
    }
    setState(() {
      _expenses.add(
        Expense(
          id: DateTime.now().toString(),
          title: enteredTitle,
          amount: enteredAmount.toInt(),
          category: _selectedCategory,
        ),
      );
    });
    _titleController.clear();
    _amountController.clear();
  }@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Իմ Ծախսերը,20600 ֏',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Անվանում'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Գումար'),
            ),
            const SizedBox(height: 16),
          
            Wrap(
              spacing: 8,
              children: Category.values.map((category) {
                return ChoiceChip(
                  label: Text('${category.emoji} ${category.title}'),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addExpense,
              child: const Text('Ավելացնել ծախսը'),
            ),
            const SizedBox(height: 20),
            Expanded(
            child: _expenses.isEmpty?
           const Center(
          child: Text('Ծախսեր դեռ չկան'),
          ):
       ListView.separated(
          itemCount: _expenses.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final expense = _expenses[index];
            return ExpenseTile(expense: expense);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }