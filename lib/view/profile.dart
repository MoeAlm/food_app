import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/text_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,),
        ),
        title: Text(
          'Profile',
          style: TextStyle(fontSize: width * 0.07, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: Colors.black,
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: '/hello',
                child: Text("Hello", style: TextStyle(color: Colors.white70),),
              ),
              PopupMenuItem(
                value: '/about',
                child: Text("About", style: TextStyle(color: Colors.white70),),
              ),
              PopupMenuItem(
                value: '/contact',
                child: Text("Contact", style: TextStyle(color: Colors.white70),),
              )
            ];
          })
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: CircleAvatar(
                radius: width * 0.2,
                child: Hero(tag: 'profile',
                child: Image.asset('assets/images/profile.jpg')),
              ),
            ).py(16),
            buildText(
              width,
              text: 'Mohammed Mustafa Almazouzi',
              size: 0.06,
              color: Colors.black,
              weight: FontWeight.bold,
            ),
            buildText(
              width,
              text: '@MoeAlm',
              size: 0.05,
              color: Colors.black26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    buildText(
                      width,
                      text: '120',
                      size: 0.1,
                      color: Colors.black,
                    ),
                    buildText(width,
                        text: 'Post', size: 0.045, color: Colors.black26)
                  ],
                ),
                const VerticalDivider(
                  color: Colors.black26,
                ),
                Column(
                  children: [
                    buildText(
                      width,
                      text: '450',
                      size: 0.1,
                      color: Colors.black,
                    ),
                    buildText(width,
                        text: 'Friends', size: 0.045, color: Colors.black26)
                  ],
                ),
                const VerticalDivider(
                  color: Colors.white70,
                ),
                Column(
                  children: [
                    buildText(
                      width,
                      text: '1225',
                      size: 0.1,
                      color: Colors.black,
                    ),
                    buildText(width,
                        text: 'Following', size: 0.045, color: Colors.black26)
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: width * 0.05, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.orange
                    ),
                  ),
                ),
                SizedBox(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.message_outlined,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ).py8(),
            const Divider(
              color: Colors.black12,
            ).px32(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildText(width,
                    text: 'Orders', size: 0.06, color: Colors.black45, weight: FontWeight.bold),
                TextButton(
                  onPressed: () {},
                  child: buildText(width,
                      text: 'See All', size: 0.05, color: Colors.orangeAccent),
                )
              ],
            ).px12(),
          ],
        ),
      ),
    );
  }
}
