import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, SayuUser>> signInWithEmail(String email, String password) async {
    try {
      final response = await _remoteDataSource.signInWithEmail(email, password);
      if (response.user != null) {
        final user = UserModel.fromSupabaseUser(response.user!);
        return Right(user);
      } else {
        return const Left(AuthFailure('로그인에 실패했습니다'));
      }
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SayuUser>> signUpWithEmail(String email, String password, String name) async {
    try {
      final response = await _remoteDataSource.signUpWithEmail(email, password, name);
      if (response.user != null) {
        final user = UserModel.fromSupabaseUser(response.user!);
        return Right(user);
      } else {
        return const Left(AuthFailure('회원가입에 실패했습니다'));
      }
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<SayuUser?> get authStateChanges {
    return _remoteDataSource.authStateChanges.map((state) {
      if (state.session?.user != null) {
        return UserModel.fromSupabaseUser(state.session!.user);
      }
      return null;
    });
  }

  @override
  Either<Failure, SayuUser?> get currentUser {
    try {
      final user = _remoteDataSource.currentUser;
      if (user != null) {
        return Right(UserModel.fromSupabaseUser(user));
      }
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}