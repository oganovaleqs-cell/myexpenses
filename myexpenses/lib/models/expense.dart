enum Category {
  food('Սնունդ', '🍔', 3000),
  transport('Տրանսպորտ', '🚌', 10600),
  funs('Զվարճանք', '🎮', 5000),
  other('Այլ','📦', 2000);
  final String title;
  final String emoji;
  final int amount;
  const Category(this.title, this.emoji,this.amount);
}
class Expense {
  final String id;
  final String title;
  final int amount;
  final Category category;
  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
  });
}