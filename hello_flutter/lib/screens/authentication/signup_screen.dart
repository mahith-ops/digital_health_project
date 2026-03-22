import 'package:flutter/material.dart';
import 'package:hello_flutter/components/button/button.dart';
import 'package:hello_flutter/components/snackbar/snackbar.dart';
import 'package:hello_flutter/components/text-field/text_field.dart' as custom;
import 'package:hello_flutter/services/api_exception.dart';
import 'package:hello_flutter/services/auth_service.dart';
import 'package:hello_flutter/screens/home/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _agreeToTerms = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  bool _isLoading = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    super.dispose();
  }

  void _validateName(String value) {
    if (value.isEmpty) {
      _nameError = null; // Optional
    } else if (value.trim().length < 2) {
      _nameError = 'Name must be at least 2 characters';
    } else {
      _nameError = null;
    }
    setState(() {});
  }

  void _validateEmail(String value) {
    if (value.isEmpty) {
      _emailError = 'Email is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
      _emailError = 'Please enter a valid email';
    } else {
      _emailError = null;
    }
    setState(() {});
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      _passwordError = 'Password is required';
    } else if (value.length < 6) {
      _passwordError = 'Password must be at least 6 characters';
    } else {
      _passwordError = null;
    }
    setState(() {});
  }

  void _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      _confirmPasswordError = 'Confirm password is required';
    } else if (value != _password) {
      _confirmPasswordError = 'Passwords do not match';
    } else {
      _confirmPasswordError = null;
    }
    setState(() {});
  }

  Future<void> _register() async {
    _formKey.currentState?.save();
    _validateName(_name);
    _validateEmail(_email);
    _validatePassword(_password);
    _validateConfirmPassword(_confirmPassword);

    if (!_agreeToTerms) {
      Snackbar.show(
        context,
        message: 'Please agree to Terms & Privacy Policy',
        type: SnackbarType.error,
      );
      return;
    }

    if (_nameError != null || _emailError != null || _passwordError != null || _confirmPasswordError != null) {
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final name = _name.trim().isEmpty ? null : _name.trim();
      final response = await _authService.register(
        _email,
        _password,
        name,
      );

      if (mounted) {
        Snackbar.show(
          context,
          message: 'Account created successfully!',
          type: SnackbarType.success,
        );
        _handlePostRegistration(response);
      }
    } on ApiException catch (error) {
      if (mounted) {
        final message = error.message;
        Snackbar.show(
          context,
          message: message,
          type: SnackbarType.error,
        );
      }
    } catch (error) {
      if (mounted) {
        Snackbar.show(
          context,
          message: 'Registration failed. Please try again.',
          type: SnackbarType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handlePostRegistration(Map<String, dynamic> response) {
    final requiresVerification = response['requiresVerification'] == true;
    if (requiresVerification) {
      // Placeholder: navigate to email verification flow when available.
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const VerifyEmailScreen()));
      Snackbar.show(
        context,
        message: 'Please verify your email before logging in.',
        type: SnackbarType.info,
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign up to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 48),
                custom.TextField(
                  value: _name,
                  label: 'Full Name (Optional)',
                  hint: 'Enter your full name',
                  errorText: _nameError,
                  onChanged: (value) {
                    _name = value;
                    _validateName(value);
                  },
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    if (value.trim().length < 2) return 'Name must be at least 2 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                custom.TextField(
                  value: _email,
                  label: 'Email',
                  hint: 'Enter your email',
                  errorText: _emailError,
                  onChanged: (value) {
                    _email = value;
                    _validateEmail(value);
                  },
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is required';
                    final trimmed = value.trim();
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(trimmed)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                custom.TextField(
                  value: _password,
                  label: 'Password',
                  hint: 'Enter your password',
                  errorText: _passwordError,
                  onChanged: (value) {
                    _password = value;
                    _validatePassword(value);
                    _validateConfirmPassword(_confirmPassword);
                  },
                  obscureText: !_showPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _showPassword = !_showPassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password is required';
                    if (value.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                custom.TextField(
                  value: _confirmPassword,
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  errorText: _confirmPasswordError,
                  onChanged: (value) {
                    _confirmPassword = value;
                    _validateConfirmPassword(value);
                  },
                  obscureText: !_showConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _showConfirmPassword = !_showConfirmPassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm password is required';
                    if (value != _password) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() => _agreeToTerms = value ?? false);
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _agreeToTerms = !_agreeToTerms),
                        child: const Text(
                          'I agree to Terms & Privacy Policy',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Button(
                  label: 'Create Account',
                  onPressed: _isLoading ? null : _register,
                  isLoading: _isLoading,
                  size: ButtonSize.large,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Assuming login is previous screen
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}