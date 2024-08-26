import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/screens/main/widgets/orders_chart.dart';
import 'package:food_couriers_admin/screens/main/widgets/sales_chart.dart';
import 'package:food_couriers_admin/utils.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({
    super.key,
  });

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {

  List<double> salesData = [6000, 8000, 6500, 7500, 8500, 9000, 7000, 6000, 7500, 6500, 8000, 9000];
  List<double> expensesData = [1000, 2000, 3500, 4000, 1500, 2500, 3000, 4000, 2500, 3500, 1500, 2000];
  final List<double> monthlyOrders = [50, 30, 20, 60, 70, 90, 80, 55, 40, 75, 65, 85];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _statsRow(),
            Row(
              children: [
                _charts(
                  flex: 1,
                  title: 'OVERVIEW',
                  subtitle: 'Sales',
                  chart: SalesChart(
                    salesData: salesData,
                    expensesData: expensesData,
                  ),
                ),
                _charts(
                  flex: 1,
                  title: 'PERFORMANCE',
                  subtitle: 'Total Orders',
                  chart: OrdersChart(
                    monthlyOrders: monthlyOrders,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _charts({
    required int flex,
    required String title,
    required String subtitle,
    required Widget chart,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(screenWidth! * 0.007),
        padding: EdgeInsets.all(screenWidth! * 0.01),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(screenWidth! * 0.01),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.silver,
                fontFamily: 'DM Sans',
                fontSize: screenWidth! * 0.006,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textDarkColor,
                fontFamily: 'DM Sans',
                fontSize: screenWidth! * 0.015,
                fontWeight: FontWeight.w700,
                height: 1,
                letterSpacing: -0.02 * screenWidth! * 0.015,
              ),
            ),
            SizedBox(height: screenWidth! * 0.02),
            SizedBox(
              height: screenWidth! * 0.2,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        statsCard(
          icon: Icons.bar_chart_rounded,
          title: 'Earnings',
          value: '\$ 350.4',
        ),
        statsCard(
          icon: Icons.attach_money_rounded,
          title: 'Spend this month',
          value: '\$ 642.49',
        ),
        statsCard(
          icon: Icons.shopping_cart_checkout_rounded,
          title: 'Sales',
          value: '\$ 574.34',
        ),
        statsCard(
          icon: Icons.table_restaurant_rounded,
          title: 'No. of restaurant',
          value: '100',
        ),
        statsCard(
          icon: Icons.groups_rounded,
          title: 'Views',
          value: '50',
        ),
        statsCard(
          icon: Icons.checklist_outlined,
          title: 'Orders (30 days)',
          value: '100',
        ),
      ],
    );
  }

  Widget statsCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.0065),
        padding: EdgeInsets.all(screenWidth! * 0.0045),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(screenWidth! * 0.01),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth! * 0.005),
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: screenWidth! * 0.022,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: screenWidth! * 0.004),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.silver,
                    fontFamily: 'DM Sans',
                    fontSize: screenWidth! * 0.008,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: AppColors.textDarkColor,
                    fontFamily: 'DM Sans',
                    fontSize: screenWidth! * 0.012,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
