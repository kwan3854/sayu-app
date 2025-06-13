import 'package:auto_route/auto_route.dart';

// Import all screens
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/onboarding_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/main/presentation/pages/main_screen.dart';
import '../../features/briefing/presentation/pages/briefing_screen.dart';
import '../../features/prediction/presentation/pages/prediction_screen.dart';
import '../../features/reflection/presentation/pages/reflection_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: OnboardingRoute.page,
          path: '/onboarding',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),
        AutoRoute(
          page: RegisterRoute.page,
          path: '/register',
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/main',
          children: [
            AutoRoute(
              page: BriefingRoute.page,
              path: 'briefing',
            ),
            AutoRoute(
              page: PredictionRoute.page,
              path: 'prediction',
            ),
            AutoRoute(
              page: ReflectionRoute.page,
              path: 'reflection',
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile',
            ),
          ],
        ),
      ];
}