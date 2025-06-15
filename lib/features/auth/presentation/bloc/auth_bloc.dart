import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_in_with_apple_usecase.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignInWithAppleUseCase signInWithAppleUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.signInWithGoogleUseCase,
    required this.signInWithAppleUseCase,
    required this.authRepository,
  }) : super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignInRequested>(_onAuthSignInRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthSignInWithGoogleRequested>(_onAuthSignInWithGoogleRequested);
    on<AuthSignInWithAppleRequested>(_onAuthSignInWithAppleRequested);
    
    // Listen to auth state changes
    authRepository.authStateChanges.listen((user) {
      add(AuthCheckRequested());
    });
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = authRepository.currentUser;
    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (user) => user != null
          ? emit(AuthAuthenticated(user))
          : emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onAuthSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await signInUseCase(
      SignInParams(email: event.email, password: event.password),
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await signUpUseCase(
      SignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await signOutUseCase(NoParams());
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onAuthSignInWithGoogleRequested(
    AuthSignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await signInWithGoogleUseCase(NoParams());
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onAuthSignInWithAppleRequested(
    AuthSignInWithAppleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await signInWithAppleUseCase(NoParams());
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
}