import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/options/localization/l10n.dart';
import '../../../../media.dart';
import '../../../bloc/auth/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  void _validateEmail() {
    final hasEmail = _emailController.text.isNotEmpty;
    if (_isButtonEnabled != hasEmail) {
      setState(() {
        _isButtonEnabled = hasEmail;
      });
    }
  }

  void _onSend() {
    final email = _emailController.text.trim();

    context.read<AuthBloc>().add(ResetPasswordEvent(email: email));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(S.of(context).sentResetLink)));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).forgotPassword),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Media.screenHeight * 0.3,
          horizontal: Media.screenWidth * 0.2,
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: S.of(context).email,
                prefixIcon: const Icon(Icons.email_outlined),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isButtonEnabled ? _onSend : null,
              child: Text(S.of(context).send),
            ),
          ],
        ),
      ),
    );
  }
}
