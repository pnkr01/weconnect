import 'package:flutter/material.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/utils/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => mobileNavBar(context),
      desktop: (BuildContext context) => desktopNavBar(),
    );
  }

  Widget mobileNavBar(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 70),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu),
            navLogo(),
          ],
        ),
      );

  Widget desktopNavBar() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                navLogo(),
                Text('Sangrah',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: deepPurpleColor,
                        fontSize: 30)),
              ],
            ),
            Row(
              children: [
                navButton("Hello"),
                navButton("Bye"),
                navButton("zero"),
                navButton("Po"),
              ],
            ),
            ElevatedButton(
              style: borderedButtonStyle,
              onPressed: () {},
              child: const Text('Sign In'),
            )
          ],
        ),
      );
}

Widget navButton(String text) {
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
          onPressed: () {},
          child: Text(text,
              style: const TextStyle(color: Colors.black, fontSize: 18))));
}

Widget navLogo() {
  return Container(
    width: 110,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/logo.png"), fit: BoxFit.contain)),
  );
}
