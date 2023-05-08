import 'package:flutter/material.dart';
import 'package:php_flutter/components/crud.dart';
import 'package:php_flutter/components/valid.dart';
import '../../components/customtextgform.dart';
import '../../constant/api.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  Crud crud = Crud();
  bool isLoading = false;

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkSignUp, {
        'username': usernamecontroller.text,
        'email': emailcontroller.text,
        'password': passwordcontroller.text
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Account Created Successfully')));
        Navigator.of(context)
            .pushNamedAndRemoveUntil('login', (route) => false);
      } else {
        print('SignUp Failed');
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
                          prefixIcon: const Icon(Icons.person),
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }else if (value.length < 3){
                              return 'make the text longer';
                            }else if (value.length > 10){
                              return 'make the text shorter';
                            }
                            return null;
                          },
                          hint: 'USERNAME',
                          mycontroller: usernamecontroller,
                        ),
                        CustomTextFormSign(
                          prefixIcon: const Icon(Icons.email),
                          valid: (value) {
                             if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }else if (value.length < 3){
                              return 'make the text longer';
                            }else if (value.length > 10){
                              return 'make the text shorter';
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
                            }else if (value.length < 3){
                              return 'make the text longer';
                            }else if (value.length > 10){
                              return 'make the text shorter';
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
                            await signUp();                          
                          },
                          child: const Text('SIGN UP'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).popAndPushNamed('login');
                            },
                            child: const Text('LOGIN')),
                      ],
                    )),
              ]),
            ),
    );
  }
}
