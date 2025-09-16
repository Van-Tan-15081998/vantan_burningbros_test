import 'package:flutter/material.dart';
import 'package:product_demo/state_management/product/favorite_provider.dart';
import 'package:product_demo/state_management/product/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  final _searchController = TextEditingController();

  ProductProvider? productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        await productProvider?.fetchProducts(loadMore: true);
      }
    });

    ///
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productProvider?.networkProvider?.onReCheckStatus();

      if (productProvider?.urlParameter?.queryString?.isNotEmpty == true) {
        _searchController.text = productProvider?.urlParameter?.queryString ?? '';
      }

      await productProvider?.favoriteProvider?.loadFavorites();

      await productProvider?.fetchProducts();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    productProvider?.onReset();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return TextField(
              controller: _searchController,
              onChanged: (value) {
                productProvider?.search(value);
              },
              cursorColor: Colors.blue,
              cursorWidth: 2.0,
              cursorRadius: const Radius.circular(4),
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: productProvider?.urlParameter?.queryString?.isNotEmpty == true
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.text = '';
                          productProvider?.search('');
                        },
                      )
                    : Container(),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
            );
          },
        ),
      ),

      body: Consumer2<ProductProvider, FavoriteProvider>(
        builder: (context, provider, favoriteProvider, child) {
          if (provider.errorMessage?.isNotEmpty == true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 50, color: Colors.red),
                  SizedBox(height: 8),
                  Text(provider.errorMessage!, style: TextStyle(), textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.fetchProducts(loadMore: false);
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (provider.products.isEmpty && provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.products.isEmpty) {
            return Center(child: Text("No data available"));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: provider.products.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.products.length) {
                return provider.isLoading ? Center(child: CircularProgressIndicator()) : Center(child: Text("End of list"));
              }

              final product = provider.products[index];

              final bool isFavorite = provider.favoriteProvider?.isFavorite(product.id) ?? false;

              return ListTile(
                leading: Image.network(product.image, width: 50, height: 50), //
                title: Text(product.name), //
                subtitle: Text("\$${product.price}"), //

                trailing: IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : null),
                  onPressed: () {
                    provider.favoriteProvider?.toggleFavorite(product.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
