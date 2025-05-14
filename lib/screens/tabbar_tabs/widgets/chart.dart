import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';

class MBarChart extends StatelessWidget {
  final List<TransactionModel> transactions;
  final TransactionType type;

  const MBarChart({
    super.key,
    required this.transactions,
    required this.type,
  });

  List<BarChartGroupData> showGroups() {
    // Group transactions by day and sum amounts
    final Map<int, double> dailyTotals = {};

    for (final transaction in transactions) {
      if (transaction.type != type) continue;

      // Parse date from transaction (assuming format is 'dd/MM/yyyy')
      final dateParts = transaction.date.split('/');
      final day = int.parse(dateParts[0]);

      dailyTotals.update(
        day,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    // Create bar chart data
    return dailyTotals.entries.map((entry) {
      return makeGroupData(entry.key, entry.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              getTitlesWidget: (value, meta) => getBottomTiles(value, meta),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              getTitlesWidget: (value, meta) => getLeftTiles(value, meta),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        barGroups: showGroups(),
        // Set max Y value based on highest transaction
        maxY: transactions.fold(
          0,
          (max, transaction) =>
              transaction.amount > max! ? transaction.amount + 1000 : max,
        ),
      ),
    );
  }

  Widget getLeftTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: Text('${value.toInt()}k', style: style),
    );
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: Text(value.toInt().toString(), style: style),
    );
  }
}

BarChartGroupData makeGroupData(int x, double y) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        width: 15,
        gradient: MColors.barChartGradient,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          toY: y * 1.2,
          color: Colors.grey.shade300,
        ),
      )
    ],
  );
}
