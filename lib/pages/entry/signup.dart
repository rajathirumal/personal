import 'package:flutter/material.dart';
import 'package:personal/helpers/extension.dart';
import 'package:personal/services/auth_services.dart';
import 'package:personal/services/user_ops_services.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signupFormKey = GlobalKey<FormState>();

  TextEditingController displayNameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  "Hey new person,",
                  style: TextStyle(fontSize: 35.0),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sign up to continue",
                  style: TextStyle(fontSize: 25.0),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _signupFormKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            controller: displayNameTEC,
                            decoration: const InputDecoration(
                              label: Text("How do you want us to call you ?"),
                              hintText: "Display name",
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid name.(Example: Harry Potter)';
                              } else if (value.length < 3) {
                                return "Password should be atlest 3 charecters";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailTEC,
                            decoration: const InputDecoration(
                              label: Text("Login email"),
                              hintText: "Email",
                              prefixIcon: Icon(Icons.alternate_email_sharp),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.emailRegex) {
                                return 'Enter valid email.(Example: harry.potter@hogwards.com)';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            enableSuggestions: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: isPasswordHidden,
                            controller: passwordTEC,
                            decoration: InputDecoration(
                              label: const Text("Password"),
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.password_sharp),
                              suffixIcon: IconButton(
                                icon: isPasswordHidden
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                onPressed: () => setState(
                                  () => isPasswordHidden = !isPasswordHidden,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter password';
                              } else if (value.length < 6) {
                                return "Password should be atlest 6 charecters";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(20)),
                          icon:
                              const Icon(Icons.person_add, color: Colors.white),
                          onPressed: () {
                            if (_signupFormKey.currentState!.validate()) {
                              // Initiate the user with self as friend list
                              Provider.of<UserOpsServices>(context,
                                      listen: false)
                                  .initUserFriend(
                                displayName: displayNameTEC.text,
                                email: emailTEC.text,
                              );
                              //  sugn up the user
                              Provider.of<AuthServices>(context, listen: false)
                                  .signup(
                                      email: emailTEC.text.toLowerCase(),
                                      password: passwordTEC.text,displayName: displayNameTEC.text);
                            }
                            // Navigate to the login screen so that the current session makes the app to move to the home page
                            Navigator.pop(context);
                          },
                          label: const Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
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
