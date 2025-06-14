import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, SayuUser>> signInWithEmail(String email, String password);
  Future<Either<Failure, SayuUser>> signUpWithEmail(String email, String password, String name);
  Future<Either<Failure, SayuUser>> signInWithGoogle();
  Future<Either<Failure, SayuUser>> signInWithApple();
  Future<Either<Failure, void>> signOut();
  Stream<SayuUser?> get authStateChanges;
  Either<Failure, SayuUser?> get currentUser;
}