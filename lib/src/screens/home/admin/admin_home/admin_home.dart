import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/screens/company_creation.dart';
import 'package:weconnect/src/screens/home/admin/side-menu/main_drawer.dart';
import 'package:weconnect/src/widget/my_navbar.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});
  static const routeName = '/admin-home';

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context){
              return CompanyCreation();
            }));
        },
        child: Icon(Icons.create_new_folder),
      ),
      body: Center(
        child: Text("admin home page"),
      ),
    );
  }
}
