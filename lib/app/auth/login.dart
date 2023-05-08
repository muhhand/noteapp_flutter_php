import 'package:flutter/material.dart';
import 'package:php_flutter/constant/api.dart';
import 'package:php_flutter/main.dart';

import '../../components/crud.dart';
import '../../components/customtextgform.dart';
import '../../components/valid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  Crud crud = Crud();
  bool isLoading = false;

  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin, {
        'email': emailcontroller.text,
        'password': passwordcontroller.text,
      });
      isLoading = false;
      setState(() {});
      if (response["status"] == "success") {
        sharedPref.setString('id', response['data']['id'].toString());
        sharedPref.setString('username', response['data']['username']);
        sharedPref.setString('email', response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Account Not Found or email or password incorrect')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(children: [
                Form(
                    key: formstate,
                    child: Column(
                      children: [
                        Image.asset('assets/note.jpg'),
                        CustomTextFormSign(
                          prefixIcon: const Icon(Icons.email),
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          hint: 'EMAIL',
                          mycontroller: emailcontroller,
                        ),
                        CustomTextFormSign(
                          prefixIcon: const Icon(Icons.lock),
                          valid: (value) {
                             if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          hint: 'PASSWORD',
                          mycontroller: passwordcontroller,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          onPressed: () async {
                            await login();
                          },
                          child: const Text('LOGIN'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('signup');
                            },
                            child: const Text('Sign Up')),
                      ],
                    )),
              ]),
            ),
    );
  }
}
