import 'package:flutter/material.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/accepted-coord.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/pending-coord.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CoordRequestPage extends StatelessWidget {
  const CoordRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
      length: 2,
      child: Scaffold(
        body: Column(children: [
          TabBar(
            tabs:
          [
            Tab(text: 'ACCEPTED',),
            Tab(text: 'PENDING',),
          ],
          
           ),
           Expanded(child: TabBarView(children: [
            AcceptedCoordinators(),
            PendingCoordinators()
           ]))
        ]),
      ));
  }
}