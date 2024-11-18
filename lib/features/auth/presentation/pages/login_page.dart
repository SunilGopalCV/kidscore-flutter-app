/*

Login Page

on this page, an user can login to the app using email and password

once the user is logged in, the user will be redirected to the home page

If the user doesn't have an account, the user can navigate to the register page

*/

import 'package:flutter/material.dart';
import 'package:kidscore/features/auth/presentation/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final emailController = TextEditingController();
  final pwController = TextEditingController();

// Build ui
  @override
  Widget build(BuildContext context) {
    // Scaffold
    return Scaffold(
        // Body
        body: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Icon(
                          Icons.lock_open_rounded,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary,
                        ),

                        const SizedBox(height: 50),

                        // Welcome back smg
                        Text("Sign in",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            )),

                        const SizedBox(height: 25),

                        // emai textfield
                        MyTextField(
                            hintText: "example@xyz.com",
                            controller: emailController,
                            obscureText: false),

                        const SizedBox(height: 10),

                        MyTextField(
                            hintText: "*Minimum 8 characters",
                            controller: emailController,
                            obscureText: true)
                        // pw textfield

                        // login button

                        // not a member? register here
                      ],
                    )))) // Column
        );
  }
}
