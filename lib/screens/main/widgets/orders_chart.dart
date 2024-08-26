import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class OrdersChart extends StatelessWidget {
  final List<double> monthlyOrders;

  const OrdersChart({
    super.key,
    required this.monthlyOrders,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: 100,
        minY: 0,
        barGroups: barChartGroups,
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
                  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
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
              reservedSize: screenWidth! * 0.02,
              interval: 10,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: EdgeInsets.only(right: screenWidth! * 0.003),
                  child: Text(
                    value.toString(),
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
        gridData: const FlGridData(drawVerticalLine: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  List<BarChartGroupData> get barChartGroups {
    return List.generate(
      monthlyOrders.length,
      (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: monthlyOrders[index],
              color: AppColors.primary,
              width: screenWidth! * 0.008,
            ),
          ],
        );
      },
    );
  }
}
