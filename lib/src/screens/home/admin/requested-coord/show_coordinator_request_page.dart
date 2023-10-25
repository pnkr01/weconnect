import 'package:flutter/material.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/screens/home/admin/drawer/drawer.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/accepted-coordinator.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/pending-coordinator.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            drawer: MainDrawer(userRole: UserRole.coordinator),
            appBar: AppBar(
              title: Text(
                "REQUESTS",
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: color1,
            ),
            body: Column(children: [
              TabBar(
                indicatorColor: color1,
                labelColor: color1,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
                tabs: [
                  Tab(
                    text: 'ACCEPTED',
                  ),
                  Tab(
                    text: 'PENDING',
                  ),
                ],
              ),
              Expanded(
                  child: TabBarView(children: [
                AcceptedCoordinators(),
                PendingCoordinators()
              ]))
            ])));
  }
}
