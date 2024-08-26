import 'package:flutter/material.dart';

class FinancesBody extends StatefulWidget {
  const FinancesBody({super.key});

  @override
  State<FinancesBody> createState() => _FinancesBodyState();
}

class _FinancesBodyState extends State<FinancesBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text(
          'Finances',
        ),
      ),
    );
  }
}
