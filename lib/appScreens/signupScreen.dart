import 'package:flutter/material.dart';
import 'package:thefoodhub/controllers/auth_controllers.dart';
import 'package:get/get.dart';

import '../components/authButton.dart';
import '../components/loginTextField.dart';
import 'signinScreen.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instance of auth controller
    AuthController authController = AuthController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          "The Food Hub",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Image.asset(
              "assets/logo.png",
              width: MediaQuery.of(context).size.width,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Create an Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // let's make text form field after we will convert into a component
            ReusableTextField(
              labelText: 'Email',
              controller: authController.emailController,
              validator: (value) {},
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
              labelText: 'Password',
              controller: authController.passwordController,
              validator: (value) {},
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),

            // Lets make a custom button and convert into a component
            ReusablePrimaryButton(
              onTap: () {
                authController.createAccount();
              },
              buttonText: 'Sign Up',
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Get.to(SignIn());
                  },
                  child: const Text('Login',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange)),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
