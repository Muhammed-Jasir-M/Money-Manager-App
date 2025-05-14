import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';

class MLineChart extends StatelessWidget {
  const MLineChart({
    super.key,
    required this.transactions,
    required this.type,
  });

  final List<TransactionModel> transactions;
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    // Group transactions by date
    final dateMap = <DateTime, double>{};
    for (var transaction in transactions) {
      final date = transaction.date;
      dateMap.update(
        date as DateTime,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    // Sort by date
    final sortedDates = dateMap.keys.toList()..sort();

    // Prepare spots for the chart
    final spots = sortedDates.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        dateMap[entry.value]!,
      );
    }).toList();

    return Column(
      children: [
        Text(
          '${type == TransactionType.income ? 'Income' : 'Expense'} Over Time',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((spot) {
                      final date = sortedDates[spot.x.toInt()];
                      return LineTooltipItem(
                        '${MHelperFunctions.formatDate(date)}\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: MHelperFunctions.formatCurrency(spot.y),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= sortedDates.length) {
                        return Container();
                      }
                      final date = sortedDates[value.toInt()];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${date.day}/${date.month}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                    reservedSize: 30,
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
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              minX: 0,
              maxX: (sortedDates.length - 1).toDouble(),
              minY: 0,
              maxY: dateMap.values.reduce((a, b) => a > b ? a : b) * 1.2,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: type == TransactionType.income
                      ? Colors.green
                      : Colors.red,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: (type == TransactionType.income
                            ? Colors.green
                            : Colors.red)
                        .withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
