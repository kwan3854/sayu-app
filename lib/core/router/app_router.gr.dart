// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BriefingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BriefingScreen(),
      );
    },
    DailyBriefingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DailyBriefingScreen(),
      );
    },
    IssueDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<IssueDetailRouteArgs>(
          orElse: () =>
              IssueDetailRouteArgs(issueId: pathParams.getString('issueId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: IssueDetailScreen(
          key: args.key,
          issueId: args.issueId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    NewsDetailRoute.name: (routeData) {
      final args = routeData.argsAs<NewsDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewsDetailScreen(
          key: args.key,
          newsItem: args.newsItem,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    PredictionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PredictionScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    ReflectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReflectionScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    WriteReflectionRoute.name: (routeData) {
      final args = routeData.argsAs<WriteReflectionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WriteReflectionScreen(
          key: args.key,
          issueId: args.issueId,
          issueTitle: args.issueTitle,
          perspectivesSeen: args.perspectivesSeen,
          predictionMade: args.predictionMade,
        ),
      );
    },
  };
}

/// generated route for
/// [BriefingScreen]
class BriefingRoute extends PageRouteInfo<void> {
  const BriefingRoute({List<PageRouteInfo>? children})
      : super(
          BriefingRoute.name,
          initialChildren: children,
        );

  static const String name = 'BriefingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DailyBriefingScreen]
class DailyBriefingRoute extends PageRouteInfo<void> {
  const DailyBriefingRoute({List<PageRouteInfo>? children})
      : super(
          DailyBriefingRoute.name,
          initialChildren: children,
        );

  static const String name = 'DailyBriefingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IssueDetailScreen]
class IssueDetailRoute extends PageRouteInfo<IssueDetailRouteArgs> {
  IssueDetailRoute({
    Key? key,
    required String issueId,
    List<PageRouteInfo>? children,
  }) : super(
          IssueDetailRoute.name,
          args: IssueDetailRouteArgs(
            key: key,
            issueId: issueId,
          ),
          rawPathParams: {'issueId': issueId},
          initialChildren: children,
        );

  static const String name = 'IssueDetailRoute';

  static const PageInfo<IssueDetailRouteArgs> page =
      PageInfo<IssueDetailRouteArgs>(name);
}

class IssueDetailRouteArgs {
  const IssueDetailRouteArgs({
    this.key,
    required this.issueId,
  });

  final Key? key;

  final String issueId;

  @override
  String toString() {
    return 'IssueDetailRouteArgs{key: $key, issueId: $issueId}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewsDetailScreen]
class NewsDetailRoute extends PageRouteInfo<NewsDetailRouteArgs> {
  NewsDetailRoute({
    Key? key,
    required NewsItem newsItem,
    List<PageRouteInfo>? children,
  }) : super(
          NewsDetailRoute.name,
          args: NewsDetailRouteArgs(
            key: key,
            newsItem: newsItem,
          ),
          initialChildren: children,
        );

  static const String name = 'NewsDetailRoute';

  static const PageInfo<NewsDetailRouteArgs> page =
      PageInfo<NewsDetailRouteArgs>(name);
}

class NewsDetailRouteArgs {
  const NewsDetailRouteArgs({
    this.key,
    required this.newsItem,
  });

  final Key? key;

  final NewsItem newsItem;

  @override
  String toString() {
    return 'NewsDetailRouteArgs{key: $key, newsItem: $newsItem}';
  }
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PredictionScreen]
class PredictionRoute extends PageRouteInfo<void> {
  const PredictionRoute({List<PageRouteInfo>? children})
      : super(
          PredictionRoute.name,
          initialChildren: children,
        );

  static const String name = 'PredictionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReflectionScreen]
class ReflectionRoute extends PageRouteInfo<void> {
  const ReflectionRoute({List<PageRouteInfo>? children})
      : super(
          ReflectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReflectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WriteReflectionScreen]
class WriteReflectionRoute extends PageRouteInfo<WriteReflectionRouteArgs> {
  WriteReflectionRoute({
    Key? key,
    required String issueId,
    required String issueTitle,
    required List<String> perspectivesSeen,
    String? predictionMade,
    List<PageRouteInfo>? children,
  }) : super(
          WriteReflectionRoute.name,
          args: WriteReflectionRouteArgs(
            key: key,
            issueId: issueId,
            issueTitle: issueTitle,
            perspectivesSeen: perspectivesSeen,
            predictionMade: predictionMade,
          ),
          initialChildren: children,
        );

  static const String name = 'WriteReflectionRoute';

  static const PageInfo<WriteReflectionRouteArgs> page =
      PageInfo<WriteReflectionRouteArgs>(name);
}

class WriteReflectionRouteArgs {
  const WriteReflectionRouteArgs({
    this.key,
    required this.issueId,
    required this.issueTitle,
    required this.perspectivesSeen,
    this.predictionMade,
  });

  final Key? key;

  final String issueId;

  final String issueTitle;

  final List<String> perspectivesSeen;

  final String? predictionMade;

  @override
  String toString() {
    return 'WriteReflectionRouteArgs{key: $key, issueId: $issueId, issueTitle: $issueTitle, perspectivesSeen: $perspectivesSeen, predictionMade: $predictionMade}';
  }
}
