import 'package:flutter/material.dart';

class SupportBody extends StatefulWidget {
  const SupportBody({super.key});

  @override
  State<SupportBody> createState() => _SupportBodyState();
}

class _SupportBodyState extends State<SupportBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text(
          'Support',
        ),
      ),
    );
  }
}