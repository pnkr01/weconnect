

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/screens/home/coordinators/company_testimonials.dart';
import 'package:weconnect/src/utils/global.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CompanySearchScreen extends StatefulWidget {
  @override
  _CompanySearchScreenState createState() => _CompanySearchScreenState();
}

class _CompanySearchScreenState extends State<CompanySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: whiteColor, size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: color1,
        title: Text(
          'Search Companies',
          style: TextStyle(color: whiteColor, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: _searchController,
              onChanged: _startSearch,
              decoration: InputDecoration(
                labelText: 'Search for companies',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchController.clear();
                    _startSearch('');
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isNotEmpty
                ? _buildSearchResults()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/gifs/search.gif',
                      ),
                      Text('No results'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _startSearch(String query) async {
    Query queryRef = FirebaseFirestore.instance.collection('companies');

    if (query.isNotEmpty) {
      queryRef =
          queryRef.orderBy('name').startAt([query]).endAt([query + '\uf8ff']);

      final QuerySnapshot result = await queryRef.get();
      setState(() {
        _searchResults = result.docs;
      });
    }
  }

  Widget _buildSearchResults() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final companyData =
              _searchResults[index].data() as Map<String, dynamic>;
          if (UserRole.admin == true) {
            return Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black54)],
                    borderRadius: BorderRadius.circular(16),
                    color: greyCOlor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(capitalizeFirstLetter(companyData['name']).toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Text(companyData['role'])
                      ],
                    ),
                  ),
                  ),);
            
            //  ListTile(

            //   onTap: () {
                
            //   },
            //   title: Text(capitalizeFirstLetter(companyData['name'])),
            //   subtitle: Text(companyData['role']),
            //   // Add other fields you want to display
            // );
          } else {

            return InkWell(
              onTap: ()
              {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CompanyTestimonials();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black54)],
                    borderRadius: BorderRadius.circular(16),
                    color: greyCOlor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(capitalizeFirstLetter(companyData['name']).toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Text(companyData['role'])
                      ],
                    ),
                  ),
                ),
              ),
            );
            
            
            // ListTile(
            //   onTap: () {
            //    Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return CompanyTestimonials();
            //     }));
            //   },
            //   title: Text(capitalizeFirstLetter(companyData['name'])),
            //   subtitle: Text(companyData['role']),
            //   // Add other fields you want to display
            // );
          }
    
        }
        );
  }
}
