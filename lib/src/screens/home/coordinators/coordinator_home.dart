import 'package:flutter/material.dart';

class CoordinatorHomePage extends StatelessWidget {
  const CoordinatorHomePage({super.key});
  static const routeName = '/coordinator-home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Coord home page"),
      ),
    );
  }
}
