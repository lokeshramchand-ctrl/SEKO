// ignore_for_file: library_private_types_in_public_api, unused_import, avoid_print, use_build_context_synchronously, sort_child_properties_last, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:seko/First%20Sector/loginbutton.dart';
import 'package:seko/enviroment.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  static const _secureStorage = FlutterSecureStorage();

  Future<void> login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse('${Environment.baseUrl}/api/token/');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access'];
        await _secureStorage.write(key: 'access_token', value: accessToken);
        print('Login successful, token: $accessToken');

        // Navigate to next page after successful login
        Navigator.pushNamed(context, '/homepage');
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          _errorMessage = data['detail'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Login',
                    style: GoogleFonts.albertSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.albertSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 150),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(emailController, "Username"),
                const SizedBox(height: 30),
                _buildPasswordWithForgot(passwordController),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 50),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: login,
                        child: const Text('Next'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFFCD956,
                          ), // Your button color
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 15,
                          ),
                          textStyle: GoogleFonts.albertSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildPasswordWithForgot(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildTextField(controller, "Password", obscureText: true),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/homepage');
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 5, top: 10),
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.albertSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFCD956),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildTextField(
  TextEditingController controller,
  String hintText, {
  bool obscureText = false,
}) {
  return Container(
    width: 300,
    height: 70,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFD9D9D9),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFFCD956), width: 1.0),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.albertSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.6),
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
      style: GoogleFonts.albertSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
  );
}
