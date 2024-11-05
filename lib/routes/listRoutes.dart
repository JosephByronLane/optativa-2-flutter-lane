import 'package:examen_movil/routes/routes.dart';
import 'package:examen_movil/screens/categoriesScreen.dart';
import 'package:examen_movil/screens/detailsScreen.dart';
import 'package:examen_movil/screens/loginScreen.dart';
import 'package:examen_movil/screens/productsScreen.dart';
import 'package:flutter/material.dart';

class ListRoutes {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routes.loginScreen: (context) => loginScreen(),
    Routes.categoryScreen: (context) =>  Categoriesscreen(),
    Routes.productsScreen: (context) =>  Productsscreen(),
    Routes.detailsScreen: (context) => Detailsscreen(),
  };

  // static List<MenuOptions> menuOptions = [
  //   MenuOptions(
  //       route: Routes.login,
  //       screen: loginScreen(),
  //       icon: Icons.access_alarm_sharp,
  //       description: "Pantalla login"),
  //   MenuOptions(
  //       route: Routes.list,
  //       screen: const listScreen(),
  //       icon: Icons.list_alt_sharp,
  //       description: "Pantalla listado"),
  //   MenuOptions(
  //       route: Routes.empleados,
  //       screen: const employeeScreen(),
  //       icon: Icons.pause_circle_sharp,
  //       description: "Pantalla empleados"),
  // ];
}
