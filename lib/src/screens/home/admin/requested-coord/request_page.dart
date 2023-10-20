import 'package:flutter/material.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/accepted-coord.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/pending-coord.dart';
import 'package:weconnect/src/screens/home/admin/side-menu/main_drawer.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
     DefaultTabController(
      
      length: 2,
      child:
       Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(title: Text("ALL CO-ORDINATORS"),centerTitle: true,),
        body: Column(
          children: [
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
           ])
           )
          ]
      )));
  }
}