import 'package:flutter/material.dart';
import '../authonication/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfeild.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

  void register(BuildContext context) {
    final _auth = AuthService();
    if(_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      try{
        _auth.signUpWithEmailPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } catch (e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()
            ),
          ),
        );
      }
    }
    else{
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Passwords do not match."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),

            // Welcome message
            Text(
              "Let's create an account for you!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),

            // Email field
            MyTextfeild(
              controller: _emailController,
              hintText: "Email",
              icon: Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
              obscureText: false,
            ),
            const SizedBox(height: 10),

            // Password field
            MyTextfeild(
              controller: _passwordController,
              hintText: "Password",
              icon: Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
              obscureText: true,
            ),
            const SizedBox(height: 10),

            // Confirm Password field
            MyTextfeild(
              controller: _confirmPasswordController,
              hintText: "Confirm Password",
              icon: Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
              obscureText: true,
            ),
            const SizedBox(height: 25),

            // Register button
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(height: 10),

            // Already have an account? Login now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Login now',
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
    );
  }
}
