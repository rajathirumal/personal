import 'package:flutter/material.dart';
import 'package:personal/pages/entry/signup.dart';
import 'package:personal/helpers/extension.dart';
import 'package:personal/services/auth_services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool loginError = false;
  int missedPassword = 0;
  bool isPasswordHidden = true;

  final _formKey = GlobalKey<FormState>();
  final _passResetForm = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

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
                  "Welcome Back,",
                  style: TextStyle(fontSize: 35.0),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sign in to continue",
                  style: TextStyle(fontSize: 25.0),
                ),
                const SizedBox(height: 30),
                // Login time issue banner
                Visibility(
                  visible: loginError,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline_outlined,
                                size: 40,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Invalid user:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Kindly Check you creadentials ...",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                // Login form
                Form(
                  key: _formKey,
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
                            controller: emailController,
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: "Email",
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.emailRegex) {
                                return 'Enter valid email.(Example: user@domain.com)';
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
                            controller: passController,
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
                          icon: const Icon(Icons.login, color: Colors.white),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<AuthServices>()
                                  .login(
                                    email: emailController.text,
                                    password: passController.text,
                                  )
                                  .then(
                                (value) {
                                  if (value != "Logged in") {
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      // setState(() {
                                      loginError = true;
                                      missedPassword++;
                                      // });
                                      Future.delayed(const Duration(seconds: 3),
                                          () {
                                        setState(() {
                                          loginError = false;
                                        });
                                      });
                                    });
                                  }
                                },
                              );
                            }
                          },
                          label: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Signup link
                Visibility(
                  visible: (missedPassword < 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: const Text(
                          'New user? Sign up.',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: (missedPassword >= 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          resetPasswordDialoug(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const ResetPassword(),
                          //   ),
                          // );
                        },
                        child: const Text(
                          'Try reseting the password',
                          style: TextStyle(color: Colors.blue),
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

  Future<void> resetPasswordDialoug(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password reset for'),
          content: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.black26,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Form(
                key: _passResetForm,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    hintText: "Email to reset password",
                    // prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.emailRegex) {
                      return 'Enter valid email.(Example: user@domain.com)';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Reset'),
              onPressed: () async {
                if (_passResetForm.currentState!.validate()) {
                  String snackText =
                      await Provider.of<AuthServices>(context, listen: false)
                          .resetPassword(email: emailController.text);
                  //     .then(
                  //   (value) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text(value),
                  //       ),
                  //     );
                  //   },
                  // );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(snackText),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
