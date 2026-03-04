import 'package:flutter/material.dart';
import 'package:userbook/screens/signup.dart';
import 'package:userbook/widgets/password_text_field.dart';
import 'package:userbook/widgets/text_form_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blue,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/image/formLogo.png",
                  width: 250,
                  height: 250,
                ),

                SizedBox(height: 20,),

                BuildTextField(controller: _emailController, label: "email"),
                BuildPasswordField(controller: _passwordController, label: "Password", isHidden: true, onTap: (){}),

                SizedBox(height: 25,),

                ElevatedButton(
                  onPressed: (){}, 
                  child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 16),
                  ),
                ),

                SizedBox(height: 25,),

                 SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do not have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => SignUp()),
                          );
                        },
                        child: const Text("Sign Up"),
                      )
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}