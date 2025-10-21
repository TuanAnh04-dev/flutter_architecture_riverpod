import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/product/domain/entities/product.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);
}
