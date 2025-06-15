import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/zen_button.dart';
import '../../../../shared/widgets/premium_glass_container.dart';
import '../bloc/auth_bloc.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.router.replaceNamed('/main');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
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
                    '사유의 여정을\n시작해보세요',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w300,
                          height: 1.3,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '당신만의 성찰 공간을 만들어드릴게요',
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: '이름',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: AppColors.primary,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '이름을 입력해주세요';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
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
                            if (!value.contains('@')) {
                              return '올바른 이메일 형식이 아닙니다';
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
                            if (value.length < 6) {
                              return '비밀번호는 6자 이상이어야 합니다';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: '비밀번호 확인',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.primary,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '비밀번호를 다시 입력해주세요';
                            }
                            if (value != _passwordController.text) {
                              return '비밀번호가 일치하지 않습니다';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return ZenButton(
                        text: isLoading ? '회원가입 중...' : '회원가입',
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthSignUpRequested(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      name: _nameController.text,
                                    ),
                                  );
                                }
                              },
                        width: double.infinity,
                        isLarge: true,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.router.maybePop();
                      },
                      child: Text(
                        '이미 계정이 있으신가요? 로그인',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}