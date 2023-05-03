import 'package:flutter/material.dart';
import 'package:market/screens/home_screen.dart';
import 'package:market/services/http_exception.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

enum AuthMode { Register, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  var _loading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(color: Colors.red),
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okey'),
              )
            ],
          );
        });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      // save form
      _formKey.currentState!.save();
      print(_authData);

      setState(() {
        _loading = true;
      });

      try {
        if (_authMode == AuthMode.Login) {
          // ...login user
          await Provider.of<Auth>(context, listen: false)
              .login(_authData['email']!, _authData['password']!);
        } else {
          // register user
          await Provider.of<Auth>(context, listen: false).signup(
            _authData['email']!,
            _authData['password']!,
          );
        }
        // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on HttpException catch (error) {
        var errorMessage = 'Error!';
        if (error.message.contains('EMAIL_EXISTS')) {
          errorMessage = 'this user has been';
        } else if (error.message.contains('INVALID_EMAIL')) {
          errorMessage = 'WRITE CORRECT EMAIL';
        } else if (error.message.contains('WEAK_PASSWORD')) {
          errorMessage = 'weal password';
        } else if (error.message.contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'email not found';
        } else if (error.message.contains('INVALID_PASSWORD')) {
          errorMessage = 'mistake password';
        }
        _showErrorDialog(errorMessage);
      } catch (error) {
        var errorMessage = 'Sorry Error!try later';
        _showErrorDialog(errorMessage);
      }
      setState(() {
        _loading = false;
      });
    }
  }

  void _switchMouseMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/lu.png",
                    fit: BoxFit.cover,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Please write only email!';
                      } else if (!email.contains('@')) {
                        return 'Please Write correct email  (@)  !';
                      }
                    },
                    onSaved: (email) {
                      _authData['email'] = email!;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Please write password!';
                      } else if (password.length < 6) {
                        return 'Password must be 6 number!';
                      }
                    },
                    onSaved: (password) {
                      _authData['password'] = password!;
                    },
                  ),
                  if (_authMode == AuthMode.Register)
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                          obscureText: true,
                          validator: (confirmPassword) {
                            if (_passwordController.text != confirmPassword) {
                              return 'Plese write confirm password!';
                            }
                          },
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                  _loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submit,
                          child: Text(
                            _authMode == AuthMode.Login ? 'Enter' : 'Log in',
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40),
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero)),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: _switchMouseMode,
                      child: Text(
                        _authMode == AuthMode.Login ? 'Log in' : 'Registration',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.green),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
