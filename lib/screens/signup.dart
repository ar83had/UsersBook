import 'package:flutter/material.dart';
import 'package:userbook/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userbook/screens/dummyscreen.dart';
import 'package:userbook/screens/signin.dart';
import 'package:userbook/screens/usersS.dart';
import 'package:userbook/widgets/circularprogression.dart';
import 'package:userbook/widgets/password_text_field.dart';
import 'package:userbook/widgets/text_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _companyController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();

  bool _isHidden = true;
  bool _isConfirmHidden = true;
  bool isBtnTap = false;

  Map<String,dynamic> serverError={};
  late dynamic res;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> getSharedPreferences() async{
  //   prefs = await SharedPreferences.getInstance();
  // }

  void showMsg(String msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          ElevatedButton(
            style: ButtonStyle(    backgroundColor: WidgetStateProperty.all(Colors.blue.shade500),foregroundColor: WidgetStateProperty.all(Colors.white)),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DummyScreen()));
          }, 
          child: Text("Dummy Screen")
        )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                Image.asset(
                  "assets/image/formLogo.png",
                  width: 250,
                  height: 250,
                ),

                const SizedBox(height: 20),

                BuildTextField(
                  controller: _nameController,
                  label: "Name",
                  validator: (value) =>
                      value!.isEmpty ? "Name is required" : null,
                  errorText: serverError["name"]!=null? serverError["name"][0]:null,
                ),

                BuildTextField(
                  controller: _emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return "Email is required";
                    if (!value.contains("@")) return "Enter valid email";
                    return null;
                  
                  },
                  errorText: serverError["email"]!=null?serverError["email"][0]:null,
                ),

                BuildTextField(
                  controller: _mobileController,
                  label: "Mobile",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) return "Mobile is required";
                    if (value.length < 10) return "Enter valid mobile";
                    return null;
                  },
                  errorText: serverError["mobile"]!=null?serverError["mobile"][0]:null,
                ),

                BuildPasswordField(
                  controller: _passwordController,
                  label: "Password",
                  isHidden: _isHidden,
                  onTap: () {
                    setState(() => _isHidden = !_isHidden);
                  },
                  validator: (value) {
                    if (value!.isEmpty) return "Password required";
                    if (value.length < 8)
                      return "Minimum 8 characters required";
                    return null;
                  },
                  errorText: serverError["password"]!=null?serverError["password"][0]:null,
                ),

                BuildPasswordField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  isHidden: _isConfirmHidden,
                  onTap: () {
                    setState(() => _isConfirmHidden = !_isConfirmHidden);
                  },
                  validator: (value) {
                    if (value!.isEmpty) return "Confirm password required";
                    if (value != _passwordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                  errorText: serverError["password_confirmation"]!=null?serverError["password_confirmation"][0]:null,
                ),

                BuildTextField(
                  controller: _companyController,
                  label: "Company Name",
                  validator: (value) =>
                      value!.isEmpty ? "Company name required" : null,
                  errorText: serverError["company_name"]!=null?serverError["company_name"][0]:null,
                ),

                BuildTextField(
                  controller: _addressController,
                  label: "Address",
                  validator: (value) => (value!.isEmpty)?"Address is required":null,
                  errorText: serverError["address"]!=null?serverError["address"][0]:null,
                ),

                BuildTextField(
                  controller: _cityController,
                  label: "City",
                  validator: (value)=>value!.isEmpty?"City is required":null,
                  errorText: serverError["city"]!=null?serverError["city"][0]:null,
                ),

                BuildTextField(
                  controller: _stateController,
                  label: "State",
                  validator: (value)=>value!.isEmpty?"Sate is required":null,
                  errorText: serverError["state"]!=null?serverError["state"][0]:null,
                ),

                BuildTextField(
                  controller: _postalCodeController,
                  label: "Postal Code",
                  keyboardType: TextInputType.number,
                  validator: (value)=>value!.isEmpty?"State is required":null,
                  errorText: serverError["postal_code"]!=null?serverError["postal_code"][0]:null,
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {

                      if (_formKey.currentState!.validate()) {

                        isBtnTap = true;
                        Map<String, String> form = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "mobile": _mobileController.text,
                          "password": _passwordController.text,
                          "password_confirmation":                              _confirmPasswordController.text,
                          "company_name": _companyController.text,
                          "address": _addressController.text,
                          "city": _cityController.text,
                          "state": _stateController.text,
                          "postal_code": _postalCodeController.text,
                        };

                        res = await API.signup(body: form);

                        if(res["success"]==false){
                          serverError = res["errors"];
                          showMsg(res["message"]);
                        }
                        else{
                          prefs = await SharedPreferences.getInstance();
                          print(res["data"]["token"]);
                          // prefs.setString("email", res["data"]["user"]["email"]);
                          // prefs.setString("email", res["data"]["user"]["email"]);
                          prefs.setString("token", "Bearer ${res["data"]["token"]}");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>UsersScreen()));
                        }
                        
                        isBtnTap = false;
                        setState(() {});
                      }
                    },
                    child: (isBtnTap)?
                    Circularprogression():
                    const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => SigninScreen()),
                          );
                        },
                        child: const Text("Sign In"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}