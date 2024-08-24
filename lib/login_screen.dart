
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  bool _isValidEmail(String email) {
    return email.isNotEmpty &&
        email.contains('@') &&
        email.contains('.') &&
        !email.startsWith('@') &&
        !email.endsWith('@') &&
        !email.startsWith('.') &&
        !email.endsWith('.');
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty &&
        password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'\d'));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            title: const Text('Login Successful'),
            content: const Text('You have logged in successfully.'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: suffixIcon,
        hintText: 'Enter your $label',
        hintStyle: const TextStyle(color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        filled: true,
        fillColor: const Color(0xff757575),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.login, color: Colors.white, size: 25),
        backgroundColor: const Color(0xff0288D1),
        title: const Center(
          child: Text(
            'LoginApp',
            style: TextStyle(
              color: Color(0xffFFFFFF),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffB3E5FC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 150),
              _buildTextFormField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (!_isValidEmail(value!)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                suffixIcon: const Icon(Icons.email, color: Colors.white),
              ),
              const SizedBox(height: 50),
              _buildTextFormField(
                label: 'Password',
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (!_isValidPassword(value!)) {
                    return 'Password must be at least 8 characters long with at least one uppercase letter and one digit.';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff757575),
                  minimumSize: const Size(100, 50),
                ),
                onPressed: _submitForm,
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}