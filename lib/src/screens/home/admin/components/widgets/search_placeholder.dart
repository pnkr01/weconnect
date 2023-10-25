import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/screens/home/admin/components/widgets/search_widget.dart';

Widget searchBarPlaceHolder() => Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () => Get.to(() => CompanySearchScreen()),
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
