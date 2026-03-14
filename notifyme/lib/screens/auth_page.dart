import 'package:flutter/material.dart';

import 'main_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isLogin = true;
  bool _enablePush = true;
  bool _enableEmail = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'E-posta gerekli';
    if (!trimmed.contains('@')) return 'Gecerli bir e-posta girin';
    return null;
  }

  String? _validatePassword(String? value) {
    final trimmed = value ?? '';
    if (trimmed.isEmpty) return 'Sifre gerekli';
    if (trimmed.length < 6) return 'Sifre en az 6 karakter olmali';
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final message = _isLogin ? 'Giris basarili' : 'Hesap olusturuldu';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Giris' : 'Hesap Olustur'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _isLogin
                      ? 'Uygulamaya devam etmek icin giris yapin'
                      : 'Yeni hesap olusturun',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                if (!_isLogin) ...[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Ad Soyad',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Ad soyad gerekli';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-posta',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Sifre',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  textInputAction:
                      _isLogin ? TextInputAction.done : TextInputAction.next,
                  validator: _validatePassword,
                ),
                if (!_isLogin) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmController,
                    decoration: const InputDecoration(
                      labelText: 'Sifre Tekrar',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sifre tekrar gerekli';
                      }
                      if (value != _passwordController.text) {
                        return 'Sifreler ayni olmali';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bildirim Ayarlari',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SwitchListTile(
                    title: const Text('Anlik bildirimler'),
                    value: _enablePush,
                    onChanged: (value) {
                      setState(() {
                        _enablePush = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('E-posta hatirlatmalari'),
                    value: _enableEmail,
                    onChanged: (value) {
                      setState(() {
                        _enableEmail = value;
                      });
                    },
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isLogin ? 'Giris Yap' : 'Hesap Olustur'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _toggleMode,
                  child: Text(
                    _isLogin
                        ? 'Hesabin yok mu? Hesap olustur'
                        : 'Zaten hesabin var mi? Giris yap',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
