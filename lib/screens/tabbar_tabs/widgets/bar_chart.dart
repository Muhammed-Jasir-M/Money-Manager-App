import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';

class MBarChart extends StatelessWidget {
  const MBarChart({
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

    // Convert to list of BarChartGroupData
    final barGroups = categoryMap.entries.map((entry) {
      final index = categoryMap.keys.toList().indexOf(entry.key);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            color: Color(transactions
                .firstWhere((t) => t.category.title == entry.key)
                .category
                .color),
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();

    // Get the top 5 categories by amount
    final sortedCategories = categoryMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topCategories = sortedCategories.take(5).toList();

    return Column(
      children: [
        Text(
          type == TransactionType.income ? 'Income' : 'Expense',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    type == TransactionType.income ? Colors.green : Colors.red,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Total: ${MHelperFunctions.formatCurrency(transactions.fold(0, (sum, item) => sum + item.amount))}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY:
                    (categoryMap.values.reduce((a, b) => a > b ? a : b) * 1.2),
                barGroups: barGroups,
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= categoryMap.length) {
                          return Container();
                        }
                        final category =
                            categoryMap.keys.elementAt(value.toInt());
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            category.length > 8
                                ? '${category.substring(0, 7)}...'
                                : category,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          MHelperFunctions.formatCurrency(value),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        );
                      },
                      reservedSize: 50,
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final category =
                          categoryMap.keys.elementAt(group.x.toInt());
                      return BarTooltipItem(
                        '$category\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: MHelperFunctions.formatCurrency(rod.toY),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (topCategories.isNotEmpty) ...[
          Text(
            'Top Categories',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topCategories.length,
              itemBuilder: (context, index) {
                final entry = topCategories[index];
                final percentage = (entry.value /
                        transactions.fold(
                            0, (sum, item) => sum + item.amount)) *
                    100;

                return Container(
                  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        entry.key,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        MHelperFunctions.formatCurrency(entry.value),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: type == TransactionType.income
                                  ? Colors.green
                                  : Colors.red,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
