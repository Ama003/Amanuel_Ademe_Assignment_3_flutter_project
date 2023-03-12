import 'package:flutter/material.dart';

import '../../routes.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final drawerItems = [
    {"title": "HOME", "route": Routes.home, "icon": Icons.home},
    {"title": "PROFILE", "route": Routes.profile, "icon": Icons.account_circle},
    {"title": "HISTORY", "route": Routes.history, "icon": Icons.shopping_bag},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .15,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 15),
            decoration: const BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color.fromRGBO(0, 0, 0, 0.753), BlendMode.darken),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://www.springboard.com/blog/wp-content/uploads/2022/08/programming-skills.png"))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10, left: 15),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(width: 2, color: Colors.white),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80")),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "NIGUS SOLOMON",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "@nigus116",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .5,
            margin: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = drawerItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          minimumSize: const Size(100, 50),
                          alignment: Alignment.centerLeft,
                          elevation: 0),
                      onPressed: () {
                        Navigator.pushNamed(context, item["route"].toString());
                      },
                      icon: Icon(item["icon"] as IconData?),
                      label: Text(item["title"].toString())),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
