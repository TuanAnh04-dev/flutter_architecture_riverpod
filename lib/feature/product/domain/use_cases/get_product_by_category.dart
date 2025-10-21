import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/product/domain/entities/product.dart';
import 'package:px1_mobile/feature/product/domain/repositories/product_repo.dart';

class GetProductByCategory {
  final ProductRepo repo;
  GetProductByCategory(this.repo);
  Future<Either<Failure, List<Product>>> call(String category) async {
    return await repo.getProductsByCategory(category);
  }
}
