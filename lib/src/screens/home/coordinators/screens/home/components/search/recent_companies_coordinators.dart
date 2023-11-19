import 'package:flutter/material.dart';
import 'package:weconnect/src/screens/home/admin/components/widgets/search_placeholder_admin.dart';
import 'package:weconnect/src/screens/home/coordinators/screens/home/components/recent_company/coordinator_recent_company.dart';

class SearchCompaniesCoord extends StatefulWidget {
  const SearchCompaniesCoord({super.key});

  @override
  State<SearchCompaniesCoord> createState() => _SearchCompaniesCoordState();
}

class _SearchCompaniesCoordState extends State<SearchCompaniesCoord> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchBarPlaceHolderCoord(),
        CoordinatorRecentCompanyWidget(),
      ],
    );
  }
}
