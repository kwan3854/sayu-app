import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'daily_briefing_screen.dart';

@RoutePage()
class BriefingScreen extends StatelessWidget {
  const BriefingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DailyBriefingScreen();
  }
}