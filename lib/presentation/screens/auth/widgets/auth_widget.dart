import 'package:flutter/material.dart';

import '../../../../core/options/localization/l10n.dart';

class AuthWidget extends StatefulWidget {
  final String title;
  final void Function(String email, String password) onSubmit;

  const AuthWidget({super.key, required this.title, required this.onSubmit});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
  }

  void _validateFields() {
    final isFilled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    if (_isButtonEnabled != isFilled) {
      setState(() {
        _isButtonEnabled = isFilled;
      });
    }
  }

  void _onPressed() =>
      widget.onSubmit(_emailController.text, _passwordController.text);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: S.of(context).email,
            prefixIcon: const Icon(Icons.alternate_email),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: S.of(context).password,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton.tonal(
          onPressed: _isButtonEnabled ? _onPressed : null,
          child: Text(S.of(context).send),
        ),
      ],
    );
  }
}
