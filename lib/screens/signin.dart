import 'package:flutter/material.dart';
import 'package:userbook/screens/dummyscreen.dart';
import 'package:userbook/screens/signup.dart';
import 'package:userbook/screens/usersS.dart';
import 'package:userbook/widgets/password_text_field.dart';
import 'package:userbook/widgets/text_form_field.dart';
import 'package:userbook/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  bool _isHidden = true;
  dynamic res;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SharedPreferences pref;

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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/image/formLogo.png",
                  width: 250,
                  height: 250,
                ),

                SizedBox(height: 20,),

                BuildTextField(
                  controller: _emailController, 
                  label: "email",
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Email is required";
                    }
                    return null;
                  },
                ),

                BuildPasswordField(
                  controller: _passwordController, 
                  label: "Password", 
                  isHidden: _isHidden, 
                  onTap: (){
                    setState(() => _isHidden=!_isHidden);
                  },
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Password is required";
                    }
                    else if(value.length<8){
                      return "Password at least 8 charcter";
                    }

                    return null;
                  },
                ),

                SizedBox(height: 25,),

                ElevatedButton(
                  onPressed: () async{
                    
                    if(_formKey.currentState!.validate()){
                      Map<String,String> form = {
                        "email" : _emailController.text,
                        "password" : _passwordController.text,
                      };

                      res = await API.signin(body: form);

                      if(res["success"]==false){
                        debugPrint("$res");
                      }else{
                        debugPrint("$res");
                        pref = await SharedPreferences.getInstance();
                        // pref.setString("email", res["data"]["user"]["email"]);
                        // pref.setString("password",res["data"]["user"]["password"]);
                        pref.setString("token", "Bearer ${res["data"]["token"]}");
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>UsersScreen()));
                      }
                    }
                  }, 
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