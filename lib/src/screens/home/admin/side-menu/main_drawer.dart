import 'package:flutter/material.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/coord-request.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/request_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context){
  return Container(
    height: 250,
    child: DrawerHeader(
         child: Column(
          children: [
        CircleAvatar(backgroundColor: Colors.black,radius: 40,),
        SizedBox(height: 8,),
        Text("INFO KUMAR"),
         SizedBox(height: 8,),
        Text("infokumar66@gmail.com"),
          ],
         ),
        ),
  );
}
Widget buildMenuItems(BuildContext context){
  return  Container(
    padding: EdgeInsets.all(8),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: Icon(Icons.home_outlined),
          title: Text("Home"),
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
             return AdminHomePage();
            }));
          },
        ),
         ListTile(
          leading: Icon(Icons.people),
          title: Text("Co-ordinators Requests"),
          onTap: (){
            Navigator.pop(context);
           Navigator.push(context, MaterialPageRoute(builder: (context)=>
             RequestPage()
            ));
          },
        ),  ListTile(
          leading: Icon(Icons.power_settings_new),
          title: Text("Sign Out"),
          onTap: (){

          },
        ),

      ],
    ),
  );
}