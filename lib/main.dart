import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 상태바 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const SayuApp());
}

class SayuApp extends StatelessWidget {
  const SayuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '사유 (Sāyu)',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
