import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});
  static const routeName = '/admin-home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("admin home page"),
      ),
    );
  }
}
