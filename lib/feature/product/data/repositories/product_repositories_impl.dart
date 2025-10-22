import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/exceptions.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/product/data/data_sources/product_remote_datasource.dart';
import 'package:px1_mobile/feature/product/domain/entities/product.dart';
import 'package:px1_mobile/feature/product/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepo {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final result = await remoteDataSource.getProducts();

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          ' Server failed to load products --repoImpl. ${e.message}',
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Network failed to load products --repoImpl'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final result = await remoteDataSource.getProductById(id);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure('Failed to load product, ${e.message}'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Failed to load product'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String category,
  ) async {
    throw UnimplementedError();
  }
}
