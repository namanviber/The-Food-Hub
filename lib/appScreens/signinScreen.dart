import 'package:flutter/material.dart';
import 'package:thefoodhub/controllers/auth_controllers.dart';
import 'package:thefoodhub/appScreens/signupScreen.dart';
import 'package:get/get.dart';

import '../components/authButton.dart';
import '../components/loginTextField.dart';

class SignIn extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/logo.png",
                  width: MediaQuery.of(context).size.width,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Please Signin to Continue......."),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Email',
                  controller: authController.loginEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Password',
                  controller: authController.loginPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                // Lets make a custom button and convert into a component
                ReusablePrimaryButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authController.loginUser();
                    }
                  },
                  buttonText: 'Login',

                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Get.to(const SignUp());
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
