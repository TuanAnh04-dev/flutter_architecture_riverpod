import 'package:px1_mobile/core/error.dart/exceptions.dart';
import 'package:px1_mobile/core/network/api_client.dart';
import 'package:px1_mobile/feature/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;
  ProductRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiClient.get('/products');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];
        // print(data);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load products  from dataSource');
      }
    } catch (e) {
      throw ServerException('Failed to load products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await apiClient.get('/products/${int.parse(id)}');
      if (response.statusCode == 200) {
        final dynamic data = response.data;
        return ProductModel.fromJson(data);
      } else {
        throw ServerException('Failed to load product');
      }
    } catch (e) {
      throw ServerException('Failed to load product: $e');
    }
  }
}
