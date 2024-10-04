import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';

class SalesChart extends StatelessWidget {
  final List<double> salesData;
  final List<double> expensesData;

  const SalesChart({
    super.key,
    required this.salesData,
    required this.expensesData,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 10000,
        gridData: const FlGridData(drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [salesLineChartBarData, expensesLineChartBarData],
        // showingTooltipIndicators: List.generate(salesData.length, (index) {
        //   return ShowingTooltipIndicators([
        //     LineBarSpot(
        //       salesLineChartBarData,
        //       0,
        //       salesLineChartBarData.spots[index],
        //     ),
        //   ]);
        // }),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: screenWidth! * 0.015,
              interval: 1,
              getTitlesWidget: (value, meta) {
                List<String> months = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec'
                ];

                String month = months[value.toInt() % months.length];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    month,
                    style: TextStyle(
                      color: AppColors.silver,
                      fontFamily: 'DM Sans',
                      fontSize: screenWidth! * 0.008,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: screenWidth! * 0.028,
              interval: 1000,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: EdgeInsets.only(right: screenWidth! * 0.003),
                  child: Text(
                    value.toInt().toString(),
                    maxLines: 1,
                    softWrap: false,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: AppColors.silver,
                      fontFamily: 'DM Sans',
                      fontSize: screenWidth! * 0.008,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // lineTouchData: LineTouchData(
        //   touchTooltipData: LineTouchTooltipData(
        //     getTooltipItems: (touchedSpots) {
        //       return touchedSpots.map((touchedSpot) {
        //         return LineTooltipItem(
        //           '${touchedSpot.y}',
        //           const TextStyle(color: Colors.white),
        //         );
        //       }).toList();
        //     },
        //   ),
        // ),
      ),
    );
  }

  LineChartBarData get salesLineChartBarData {
    return LineChartBarData(
      spots: List.generate(
        salesData.length,
        (index) => FlSpot(index.toDouble(), salesData[index]),
      ),
      isCurved: true,
      barWidth: screenWidth! * 0.0015,
      dotData: const FlDotData(show: false),
      color: Colors.green.shade400,
      belowBarData: BarAreaData(
        show: true,
        color: Colors.green.shade100,
      ),
    );
  }

  LineChartBarData get expensesLineChartBarData {
    return LineChartBarData(
      spots: List.generate(
        expensesData.length,
        (index) => FlSpot(index.toDouble(), expensesData[index]),
      ),
      isCurved: true,
      barWidth: screenWidth! * 0.0015,
      dotData: const FlDotData(show: false),
      color: AppColors.primary,
      belowBarData: BarAreaData(
        show: true,
        color: AppColors.primary.withOpacity(0.2),
      ),
    );
  }
}
