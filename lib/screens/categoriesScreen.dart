import 'package:examen_movil/modules/categories/domain/dto/categoriesResponse.dart';
import 'package:examen_movil/modules/categories/domain/repository/repository.dart';
import 'package:examen_movil/modules/categories/useCase/use_case.dart';
import 'package:examen_movil/screens/cartScreen.dart';
import 'package:examen_movil/screens/productsScreen.dart';
import 'package:flutter/material.dart';

class Categoriesscreen extends StatelessWidget {
  const Categoriesscreen({super.key});

 @override
  Widget build(BuildContext context) {
    Future<List<CategoriesResponse>> categories = CategoriesUseCase().execute(null);

    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: const Text(
        'Categorias',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
        ),
      ],
    ),
      body: FutureBuilder<List<CategoriesResponse>>(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go to Login'),
                  ),
                ],
              ),
            );
          }

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
                          builder: (context) =>
                              ProductsScreen(categoryUrl: options[index].url),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const Center(
            child: Text('No hay datos'),
          );
        },
      ),
    );
  }
}