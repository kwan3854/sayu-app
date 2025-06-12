import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      
      // 색상 스키마
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),
      
      // 앱바 테마
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'NotoSansKR',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: 24,
        ),
      ),
      
      // 텍스트 테마
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w300,
          letterSpacing: 1.5,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w300,
          letterSpacing: 1.2,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.8,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: AppColors.textPrimary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
      ),
      
      // 카드 테마
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: AppColors.gray800,
            width: 1,
          ),
        ),
      ),
      
      // 버튼 테마
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // 아웃라인 버튼 테마
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // 텍스트 버튼 테마
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // 다이얼로그 테마
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // 디바이더 테마
      dividerTheme: const DividerThemeData(
        color: AppColors.gray800,
        thickness: 1,
        space: 1,
      ),
    );
  }
}