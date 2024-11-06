import 'package:examen_movil/modules/categories/domain/dto/categoriesResponse.dart';
import 'package:examen_movil/modules/categories/domain/repository/repository.dart';
import 'package:examen_movil/screens/productsScreen.dart';
import 'package:flutter/material.dart';

class Categoriesscreen extends StatelessWidget {
  const Categoriesscreen({super.key});

 @override
  Widget build(BuildContext context) {
    Future<List<CategoriesResponse>> categories = CategoriesRepository().execute(null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        flexibleSpace: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Categorias',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<CategoriesResponse>>(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoriesResponse> options = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                itemCount: options.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  bool isEven = index % 2 == 0;

                  Color color = isEven ? Colors.red : Colors.blue;
                  IconData icon = isEven ? Icons.shopping_bag : Icons.food_bank;
                  
                  return ListTile(
                    leading: Icon(icon, color: color),
                    trailing: Icon(Icons.arrow_forward_ios, color: color),
                    title: Text(options[index].name),
                    subtitle: Text("Profe no hay fecha, que se pone aqui?"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(categoryUrl: options[index].url),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}