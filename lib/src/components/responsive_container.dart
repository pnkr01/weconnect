import 'package:flutter/material.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class ResponsiveCircleContainer extends StatelessWidget {
  final Widget child;

  const ResponsiveCircleContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double diameter =
        MediaQuery.of(context).size.width * 0.2; // Adjust the factor as needed

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 2.0, // How spread out the shadow is
            blurRadius: 5.0, // How blurry the shadow is
            offset: const Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
