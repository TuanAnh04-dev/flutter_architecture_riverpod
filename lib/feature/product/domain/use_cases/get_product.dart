import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/product/domain/entities/product.dart';
import 'package:px1_mobile/feature/product/domain/repositories/product_repo.dart';

class GetProducts {
  final ProductRepo repo;
  GetProducts(this.repo);
  Future<Either<Failure, List<Product>>> call() async {
    return await repo.getProducts();
  }
}
