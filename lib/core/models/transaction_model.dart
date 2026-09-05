class TransactionModel {
  const TransactionModel({
    required this.title,
    required this.dateLabel,
    required this.amount,
    required this.emoji,
    this.isIncome = false,
  });

  final String title;
  final String dateLabel;
  final double amount;
  final String emoji;
  final bool isIncome;
}
