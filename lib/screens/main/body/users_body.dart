import 'package:flutter/material.dart';

class UsersBody extends StatefulWidget {
  const UsersBody({super.key});

  @override
  State<UsersBody> createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UsersBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text(
          'User Body',
        ),
      ),
    );
  }
}