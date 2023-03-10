import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchLayout extends StatelessWidget {
  const SearchLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.1,),
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: height * 0.04,
                ),
                suffixIcon: Icon(Icons.filter_alt_outlined,
                    color: Colors.black54, size: height * 0.04),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
            ),
          ),
        ],
      ).py12().px16(),
    );
  }
}
