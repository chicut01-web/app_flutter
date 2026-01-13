import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyProgressChart extends StatelessWidget {
  const WeeklyProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => Colors.blueGrey,
              // tooltipRoundedRadius removed due to lint
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  rod.toY.round().toString(),
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];
                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        days[value.toInt()],
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            _makeGroupData(0, 5, primary),
            _makeGroupData(1, 6.5, primary),
            _makeGroupData(2, 5, primary),
            _makeGroupData(3, 7.5, primary),
            _makeGroupData(4, 9, primary),
            _makeGroupData(5, 11.5, primary),
            _makeGroupData(6, 6.5, primary),
          ],
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: color.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}
