import 'package:examen_movil/screens/cartScreen.dart';
import 'package:examen_movil/screens/searchScreen.dart';
import 'package:examen_movil/screens/viewedScreen.dart';
import 'package:flutter/material.dart';


class NavigationWidget extends StatelessWidget implements PreferredSizeWidget {
  NavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Search Icon
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
          // Shopping Cart Icon
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
          // Seen Products Icon
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewedScreen(),
                ),
              );
            },
          ),
          // User Profile Icon
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Placeholder for User Profile Screen
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
