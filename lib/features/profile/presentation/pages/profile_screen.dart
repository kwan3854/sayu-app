import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/premium_glass_container.dart';
import '../../../../shared/widgets/zen_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.router.replaceNamed('/onboarding');
        }
      },
      builder: (context, state) {
        if (state is! AuthAuthenticated) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final user = state.user;
        
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Profile Avatar
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    child: Text(
                      user.name?.isNotEmpty == true ? user.name![0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // User Name
                  Text(
                    user.name ?? '사용자',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // User Email
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 40),
                  // User Info Section
                  _buildInfoSection(context, user),
                  const SizedBox(height: 40),
                  // Settings Section
                  _buildSettingsSection(context),
                  const SizedBox(height: 40),
                  // Sign Out Button
                  ZenButton(
                    text: '로그아웃',
                    onPressed: () {
                      _showSignOutDialog(context);
                    },
                    width: double.infinity,
                    isPrimary: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoSection(BuildContext context, dynamic user) {
    return PremiumGlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '내 정보',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            context,
            icon: Icons.person_outline,
            label: '이름',
            value: user.name ?? '이름 없음',
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            icon: Icons.email_outlined,
            label: '이메일',
            value: user.email,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            icon: Icons.calendar_today_outlined,
            label: '가입일',
            value: _formatDate(user.createdAt),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return PremiumGlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '설정',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20),
          _buildSettingItem(
            context,
            icon: Icons.notifications_outlined,
            title: '알림 설정',
            onTap: () {
              // TODO: Implement notifications settings
            },
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            context,
            icon: Icons.lock_outline,
            title: '비밀번호 변경',
            onTap: () {
              // TODO: Implement password change
            },
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            context,
            icon: Icons.help_outline,
            title: '도움말',
            onTap: () {
              // TODO: Implement help
            },
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            context,
            icon: Icons.info_outline,
            title: '앱 정보',
            onTap: () {
              _showAppInfoDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '알 수 없음';
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              '취소',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthBloc>().add(const AuthSignOutRequested());
            },
            child: Text(
              '로그아웃',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showAppInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('사유'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '버전 1.0.0',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '깊이 있는 뉴스 읽기의 시작',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              '확인',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}