import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignInWithAppleUseCase implements UseCase<SayuUser, NoParams> {
  final AuthRepository repository;

  SignInWithAppleUseCase(this.repository);

  @override
  Future<Either<Failure, SayuUser>> call(NoParams params) async {
    return await repository.signInWithApple();
  }
}