import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfeild.dart';
import 'package:flutter/material.dart';
import '../authonication/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // Loading indicator

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Login method
  void login() async {
    final authService = AuthService();

    // Check if fields are empty
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Please fill in all fields."),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      await authService.signInWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView( // Prevents overflow when keyboard opens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 50),

              // Welcome message
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),

              // Email text field
              MyTextfeild(
                controller: _emailController,
                hintText: "Email",
                icon: Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
                obscureText: false,
              ),
              const SizedBox(height: 10),

              // Password text field
              MyTextfeild(
                controller: _passwordController,
                hintText: "Password",
                icon: Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
                obscureText: true,
              ),
              const SizedBox(height: 25),

              // Login button with loading indicator
              _isLoading
                  ? const CircularProgressIndicator() // Show loading spinner
                  : MyButton(
                text: "Login",
                onTap: login,
              ),
              const SizedBox(height: 10),

              // Register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member? '),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Register now',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
