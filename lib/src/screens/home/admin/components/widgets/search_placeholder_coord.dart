import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/screens/home/admin/components/widgets/search_widget_admin.dart';

Widget searchBarPlaceHolderAdmin() => Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () => Get.to(() => CompanySearchScreenAdmin()),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for companies',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
