import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:warehouse_web_app/core/constants/app_images.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/auth_provider.dart';

const int _otpLength = 4;

/// Fake OTP verification screen shown between login and the dashboard.
/// Any 4-digit code "works" — pressing Verify simply flips
/// [isLoggedInProvider] to true and navigates to /dashboard.
class OtpVerificationPage extends ConsumerStatefulWidget {
  final String email;

  const OtpVerificationPage({super.key, required this.email});

  @override
  ConsumerState<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  final List<TextEditingController> _controllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  bool _isVerifying = false;

  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _maskedEmail {
    final parts = widget.email.split('@');
    if (parts.length != 2 || parts[0].isEmpty) return widget.email;
    final local = parts[0];
    final masked = local.length <= 2
        ? '${local[0]}${'*' * (local.length - 1)}'
        : '${local.substring(0, 2)}${'*' * (local.length - 2)}';
    return '$masked@${parts[1]}';
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    setState(() {});
  }

  Future<void> _handleVerify() async {
    if (!_isComplete) return;

    setState(() => _isVerifying = true);
    // Simulate a network call.
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    ref.read(isLoggedInProvider.notifier).state = true;
    setState(() => _isVerifying = false);
    context.go('/dashboard');
  }

  void _handleResend() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP resent to $_maskedEmail.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.spaceLg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.spaceXl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: AppSizes.spaceLg),
                    const Text(
                      'OTP VERIFICATION',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceSm),
                    Text(
                      'Enter the 4-digit code sent to $_maskedEmail',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceXl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < _otpLength; i++) ...[
                          if (i > 0) const SizedBox(width: AppSizes.spaceSm),
                          SizedBox(
                            width: 56,
                            height: 56,
                            child: TextFormField(
                              controller: _controllers[i],
                              focusNode: _focusNodes[i],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColors.accentLight,
                                counterText: '',
                              ),
                              onChanged: (value) => _onDigitChanged(i, value),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceSm),
                    const Text(
                      'Didn’t receive OTP?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        // color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: _handleResend,
                      child: const Text('Resend'),
                    ),
                    const SizedBox(height: AppSizes.spaceSm),
                    ElevatedButton(
                      onPressed: (_isVerifying || !_isComplete) ? null : _handleVerify,
                      child: _isVerifying
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: AppColors.accentText),
                            )
                          : const Text(
                              'VERIFY',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          AppImages.otpEmail,
          width: 160,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: const Icon(Icons.hive_rounded, color: Colors.white, size: 30),
          ),
        ),
      ],
    );
  }
}
