import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(productsNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: productsState.when(
        // Loading state
        loading: () => const Center(child: CircularProgressIndicator()),

        // Error state
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(
                'Error: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(productsNotifierProvider.notifier).refresh();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),

        // Data state
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(productsNotifierProvider.notifier).refresh();
            },
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(productId: product.id.toString()),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
