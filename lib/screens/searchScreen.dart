import 'package:examen_movil/modules/search/domain/dto/searchResponse.dart';
import 'package:examen_movil/modules/search/useCase/useCase.dart';
import 'package:examen_movil/screens/detailsScreen.dart';
import 'package:examen_movil/widgets/navigationWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // For Debounce

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<searchResponse> _searchResults = [];
  bool _isLoading = false;
  Timer? _debounce;

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });
      Future<List<searchResponse>> searchProductDetail =
      SearchUseCase().execute(query);
    try {
      final results = await searchProductDetail;
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });

    } catch (e) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final product = _searchResults[index];
                    return ListTile(
                      title: Text(product.title),
                      subtitle: Text(product.description),
                      leading: Image.network(
                        product.thumbnail,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detailsscreen(
                              productId: product.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }
}
