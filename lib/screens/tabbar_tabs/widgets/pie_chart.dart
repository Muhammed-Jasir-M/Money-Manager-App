import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';

class MPieChart extends StatelessWidget {
  const MPieChart({
    super.key,
    required this.transactions,
    required this.type,
  });

  final List<TransactionModel> transactions;
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    // Group transactions by category
    final categoryMap = <String, double>{};
    for (var transaction in transactions) {
      final categoryName = transaction.category.title;
      categoryMap.update(
        categoryName,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    // Convert to list of PieChartSectionData
    final totalAmount =
        transactions.fold(0.0, (sum, item) => sum + item.amount);
    final sections = categoryMap.entries.map((entry) {
      final percentage = (entry.value / totalAmount) * 100;
      return PieChartSectionData(
        color: Color(transactions
            .firstWhere((t) => t.category.title == entry.key)
            .category
            .color),
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Column(
      children: [
        Text(
          '${type == TransactionType.income ? 'Income' : 'Expense'} by Category',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 40,
              sectionsSpace: 2,
              startDegreeOffset: -90,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                enabled: true,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Legend
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categoryMap.entries.map((entry) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Color(transactions
                        .firstWhere((t) => t.category.title == entry.key)
                        .category
                        .color),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  entry.key,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
