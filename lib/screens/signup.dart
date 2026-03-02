import 'package:flutter/material.dart';
import 'package:userbook/api/api.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isHidden = true;

  dynamic? res;

  @override
  Widget build(BuildContext context) {
    print("APIresponse is : $res");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              
              Image.asset(
                "assets/image/formLogo.png",
                width: 300,
                height: 300,
              ),

              /// Username
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
        
              const SizedBox(height: 15),
        
              /// Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
        
              const SizedBox(height: 15),
        
              /// Password
              TextField(
                controller: _passwordController,
                obscureText: _isHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                  ),
                ),
              ),
        
              const SizedBox(height: 25),
        
              /// Signup Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
        
                    // Map<String, String> form = {
                    //   "username": _usernameController.text,
                    //   "email": _emailController.text,
                    //   "pws": _passwordController.text,
                    // };
        
                    // await API.signup(data:form);   // make sure your API method accepts parameter
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    child: Text(
                      "signin",
                      style: TextStyle(fontSize: 17,color: Colors.deepPurple.shade500),
                    ),
                    onTap: (){},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}