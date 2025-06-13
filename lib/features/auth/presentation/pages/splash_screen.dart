import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/enso_circle.dart';

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
    
    // For MVP, skip auth check and go directly to onboarding
    // TODO: Enable auth check when Supabase is configured
    if (mounted) {
      debugPrint('Navigating to onboarding...');
      await context.router.pushNamed('/onboarding');
    }
    
    // When Supabase is configured, use this:
    // final authBloc = getIt<AuthBloc>();
    // authBloc.add(const AuthCheckRequested());
    // 
    // authBloc.stream.listen((state) {
    //   if (state is AuthAuthenticated) {
    //     context.router.replaceNamed('/main');
    //   } else if (state is AuthUnauthenticated) {
    //     context.router.replaceNamed('/onboarding');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}