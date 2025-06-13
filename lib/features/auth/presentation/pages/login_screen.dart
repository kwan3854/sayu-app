import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/zen_button.dart';
import '../../../../shared/widgets/premium_glass_container.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  '다시 만나서\n반갑습니다',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w300,
                        height: 1.3,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '사유의 여정을 계속해보세요',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 48),
                PremiumGlassContainer(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: '이메일',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이메일을 입력해주세요';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: '비밀번호',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.primary,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호를 입력해주세요';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    child: Text(
                      '비밀번호를 잊으셨나요?',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ZenButton(
                  text: '로그인',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // MVP: Mock login - 실제 Supabase 연동 전까지 사용
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('MVP 버전: 임시 로그인 중...'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      
                      Future.delayed(const Duration(seconds: 1), () {
                        if (mounted && context.mounted) {
                          context.router.replaceNamed('/main');
                        }
                      });
                      
                      // TODO: Real Supabase login
                      // context.read<AuthBloc>().add(
                      //   AuthSignInRequested(
                      //     email: _emailController.text,
                      //     password: _passwordController.text,
                      //   ),
                      // );
                    }
                  },
                  width: double.infinity,
                  isLarge: true,
                ),
                const SizedBox(height: 16),
                ZenButton(
                  text: '회원가입',
                  onPressed: () {
                    context.router.pushNamed('/register');
                  },
                  width: double.infinity,
                  isPrimary: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}