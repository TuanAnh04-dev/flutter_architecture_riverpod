import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/product/domain/entities/product.dart';
import 'package:px1_mobile/feature/product/domain/repositories/product_repo.dart';

class GetProductDetail {
  final ProductRepo repo;
  GetProductDetail(this.repo);
  Future<Either<Failure, Product>> call(String id) async {
    return await repo.getProductById(id);
  }
}
