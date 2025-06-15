import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/enso_circle.dart';
import '../bloc/auth_bloc.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Show splash for minimum duration
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    
    // Check authentication state
    context.read<AuthBloc>().add(const AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.router.replaceNamed('/main');
        } else if (state is AuthUnauthenticated) {
          context.router.replaceNamed('/onboarding');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EnsoCircle(
                size: 150,
                strokeWidth: 3,
                animate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '思',
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w200,
                        color: AppColors.primary,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Sayu',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textSecondary,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}