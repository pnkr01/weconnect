import 'package:flutter/material.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/screens/home/admin/components/widgets/search_placeholder.dart';
import 'package:weconnect/src/screens/home/admin/components/widgets/show_recent_comapnies_home_page.dart';
import 'package:weconnect/src/screens/home/admin/drawer/drawer.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class SearchCompaniesCoord extends StatefulWidget {
  const SearchCompaniesCoord({super.key});

  @override
  State<SearchCompaniesCoord> createState() => _SearchCompaniesCoordState();
}

class _SearchCompaniesCoordState extends State<SearchCompaniesCoord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
            iconTheme: IconThemeData(color: whiteColor),
            backgroundColor: color1,
            centerTitle: true,
            title: Text(
              'Sangrah',
              style: TextStyle(color: whiteColor),
            ),
          ),
          drawer: MainDrawer(userRole: UserRole.coordinator), 
     body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchBarPlaceHolder(),
          RecentCompaniesWidget(),
        ],
      ),
    );
  }
}